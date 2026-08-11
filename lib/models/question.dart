// Modelo que representa una pregunta de un examen.
class Question {
  // Texto de la pregunta.
  final String statement;

  // Opciones disponibles.
  final List<String> options;

  // Respuesta correcta.
  final String correctAnswer;

  // Respuesta elegida por el usuario.
  String? userAnswer;


  // Constructor del modelo.
  Question({
    required this.statement,
    required this.options,
    required this.correctAnswer,
    this.userAnswer,
  });


  // Crea una pregunta a partir de un JSON recibido desde una API.
  factory Question.fromJson(Map<String, dynamic> json) {

    return Question(
      statement: json['statement'],

      // Convierte la lista dinámica recibida a una lista de Strings.
      options: List<String>.from(json['options']),

      correctAnswer: json['correctAnswer'],
    );
  }
}