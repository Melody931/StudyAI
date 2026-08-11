import 'question.dart';


// Modelo que representa un examen dentro de la aplicación.
class Exam {

  // Tema del examen.
  final String topic;


  // Dificultad seleccionada.
  final String difficulty;


  // Lista de preguntas del examen.
  final List<Question> questions;



  // Constructor del modelo.
  Exam({
    required this.topic,
    required this.difficulty,
    required this.questions,
  });



  // Crea un examen a partir de un JSON recibido desde una API.
  factory Exam.fromJson(Map<String, dynamic> json) {

    return Exam(

      topic: json['topic'],

      difficulty: json['difficulty'],


      // Convierte cada pregunta JSON en un objeto Question.
      questions: (json['questions'] as List)
          .map(
            (question) => Question.fromJson(question),
          )
          .toList(),
    );
  }
}