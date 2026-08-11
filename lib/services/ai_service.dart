import 'dart:async';
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/exam.dart';

/// Servicio encargado de generar examenes mediante la API de OpenRouter.
class AiService {
  static const _endpoint = 'https://openrouter.ai/api/v1/chat/completions';
  static const _model = 'openrouter/free';

  /// Genera un examen de opcion multiple para el tema indicado.
  Future<Exam> generateExam({
    required String topic,
    required String difficulty,
    required int questionCount,
  }) async {
    final apiKey = dotenv.env['AI_API_KEY'];

    if (apiKey == null || apiKey.trim().isEmpty) {
      throw Exception(
        'No se encontro la variable AI_API_KEY en el archivo .env.',
      );
    }

    if (topic.trim().isEmpty) {
      throw ArgumentError.value(
        topic,
        'topic',
        'El tema no puede estar vacio.',
      );
    }

    if (questionCount <= 0) {
      throw ArgumentError.value(
        questionCount,
        'questionCount',
        'La cantidad de preguntas debe ser mayor que cero.',
      );
    }

    final response = await _sendRequest(
      apiKey: apiKey,
      prompt: _buildPrompt(
        topic: topic.trim(),
        difficulty: difficulty,
        questionCount: questionCount,
      ),
    );

    return _parseExam(response.body, questionCount);
  }

  Future<http.Response> _sendRequest({
    required String apiKey,
    required String prompt,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse(_endpoint),
            headers: {
              'Authorization': 'Bearer $apiKey',
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'model': _model,
              'messages': [
                {
                  'role': 'system',
                  'content':
                      'Generas examenes educativos. Responde exclusivamente con JSON valido.',
                },
                {
                  'role': 'user',
                  'content': prompt,
                },
              ],
              'temperature': 0.4,
            }),
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode < 200 || response.statusCode >= 300) {
        final details = response.body.length > 500
            ? '${response.body.substring(0, 500)}...'
            : response.body;

        throw Exception(
          'Error de OpenRouter (${response.statusCode}): $details',
        );
      }

      return response;
    } on TimeoutException {
      throw Exception(
        'La solicitud a OpenRouter excedio el tiempo de espera.',
      );
    } on http.ClientException catch (error) {
      throw Exception(
        'No se pudo conectar con OpenRouter: ${error.message}',
      );
    }
  }

  Exam _parseExam(String responseBody, int questionCount) {
    try {
      final responseJson = jsonDecode(responseBody);

      if (responseJson is! Map<String, dynamic>) {
        throw const FormatException(
          'OpenRouter devolvio una respuesta con formato invalido.',
        );
      }

      final choices = responseJson['choices'];

      String? content;

      if (choices is List && choices.isNotEmpty) {
        final firstChoice = choices.first;

        if (firstChoice is Map<String, dynamic>) {
          final message = firstChoice['message'];

          if (message is Map<String, dynamic>) {
            final text = message['content'];

            if (text is String) {
              content = text;
            }
          }
        }
      }

      if (content == null || content.trim().isEmpty) {
        throw const FormatException(
          'OpenRouter no devolvio contenido para el examen.',
        );
      }

      final examJson = jsonDecode(content);

     if (examJson is! Map<String, dynamic>) { 
        throw const FormatException(
          'El examen generado no tiene un objeto JSON valido.',
        );
      }

      final questions = examJson['questions'];

      if (questions is! List || questions.length != questionCount) {
        throw FormatException(
          'OpenRouter debe devolver exactamente $questionCount preguntas validas.',
        );
      }

      _validateQuestions(questions);

      return Exam.fromJson(examJson);
    } on FormatException catch (error) {
      throw Exception(
        'Respuesta invalida de OpenRouter: ${error.message}',
      );
    } on TypeError {
      throw Exception(
        'Respuesta invalida de OpenRouter: faltan datos del examen.',
      );
    }
  }

  void _validateQuestions(List<dynamic> questions) {
    for (final question in questions) {
      if (question is! Map<String, dynamic>) {
        throw const FormatException(
          'Una pregunta no tiene un formato valido.',
        );
      }

      final options = question['options'];
      final correctAnswer = question['correctAnswer'];

      if (question['statement'] is! String ||
          options is! List ||
          options.length != 4 ||
          !options.every((option) => option is String) ||
          correctAnswer is! String ||
          !options.contains(correctAnswer)) {
        throw const FormatException(
          'Cada pregunta debe incluir cuatro opciones y una respuesta correcta.',
        );
      }
    }
  }

  String _buildPrompt({
    required String topic,
    required String difficulty,
    required int questionCount,
  }) {
    return '''
Genera un examen de opcion multiple en espanol.

Tema: $topic
Dificultad: $difficulty
Cantidad de preguntas: $questionCount

Cada pregunta debe tener exactamente cuatro opciones y una respuesta correcta.

Devuelve unicamente un objeto JSON con este formato:

{
  "topic": "$topic",
  "difficulty": "$difficulty",
  "questions": [
    {
      "statement": "Pregunta",
      "options": [
        "Opcion A",
        "Opcion B",
        "Opcion C",
        "Opcion D"
      ],
      "correctAnswer": "Opcion correcta"
    }
  ]
}

No incluyas Markdown ni explicaciones.
''';
  }
}