import 'package:flutter/material.dart';

import '../models/exam.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import 'result_screen.dart';

/// Pantalla encargada de mostrar y responder el examen.
class ExamScreen extends StatefulWidget {
  final Exam exam;

  const ExamScreen({
    super.key,
    required this.exam,
  });

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _finishExam() {
    final unanswered =
        widget.exam.questions.any((q) => q.userAnswer == null);

    if (unanswered) {
      _showMessage(
        "Debes responder todas las preguntas antes de finalizar el examen.",
      );
      return;
    }

    final correctAnswers = widget.exam.questions
        .where((question) => question.userAnswer == question.correctAnswer)
        .length;

    final percentage = widget.exam.questions.isEmpty
        ? 0.0
        : (correctAnswers / widget.exam.questions.length) * 100;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ResultScreen(
          exam: widget.exam,
          correctAnswers: correctAnswers,
          percentage: percentage,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Examen"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.exam.topic,
                        style: AppTextStyles.title,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        "Dificultad: ${widget.exam.difficulty}",
                        style: AppTextStyles.bodySecondary,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        "${widget.exam.questions.length} preguntas",
                        style: AppTextStyles.bodySecondary,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              Text(
                "Preguntas",
                style: AppTextStyles.title,
              ),

              const SizedBox(height: AppSpacing.md),

              Expanded(
                child: ListView.separated(
                  itemCount: widget.exam.questions.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: AppSpacing.md),
                  itemBuilder: (context, index) {
                    final question = widget.exam.questions[index];

                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pregunta ${index + 1}",
                              style: AppTextStyles.subtitle,
                            ),

                            const SizedBox(height: AppSpacing.sm),

                            Text(
                              question.statement,
                              style: AppTextStyles.body,
                            ),

                            const SizedBox(height: AppSpacing.md),

                            ...question.options.map(
                              (option) => RadioListTile<String>(
                                contentPadding: EdgeInsets.zero,
                                title: Text(option),
                                value: option,
                                groupValue: question.userAnswer,
                                onChanged: (value) {
                                  setState(() {
                                    question.userAnswer = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _finishExam,
                  child: const Text(
                    "Finalizar examen",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}