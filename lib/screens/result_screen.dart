import 'package:flutter/material.dart';

import '../models/exam.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

/// Pantalla encargada de mostrar el resultado del examen.
class ResultScreen extends StatelessWidget {
  final Exam exam;
  final int correctAnswers;
  final double percentage;

  const ResultScreen({
    super.key,
    required this.exam,
    required this.correctAnswers,
    required this.percentage,
  });

  String getResultMessage() {
    if (percentage >= 90) {
      return "¡Excelente trabajo!";
    }

    if (percentage >= 70) {
      return "¡Buen progreso!";
    }

    return "Sigue practicando, puedes mejorar.";
  }

  @override
  Widget build(BuildContext context) {
    final incorrectAnswers =
        exam.questions.length - correctAnswers;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Resultados"),
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
                    children: [
                      Text(
                        "Resultado final",
                        style: AppTextStyles.title,
                      ),

                      const SizedBox(
                        height: AppSpacing.md,
                      ),

                      Text(
                        "${percentage.toStringAsFixed(1)}%",
                        style: AppTextStyles.headline,
                      ),

                      const SizedBox(
                        height: AppSpacing.sm,
                      ),

                      Text(
                        getResultMessage(),
                        style: AppTextStyles.subtitle,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: AppSpacing.lg,
              ),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tema: ${exam.topic}",
                        style: AppTextStyles.title,
                      ),

                      const SizedBox(
                        height: AppSpacing.md,
                      ),

                      Text(
                        "✅ Correctas: $correctAnswers",
                        style: TextStyle(
                          color: AppColors.success,
                        ),
                      ),

                      Text(
                        "❌ Incorrectas: $incorrectAnswers",
                        style: TextStyle(
                          color: AppColors.error,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: AppSpacing.lg,
              ),

              Text(
                "Corrección del examen",
                style: AppTextStyles.title,
              ),

              const SizedBox(
                height: AppSpacing.md,
              ),

              Expanded(
                child: ListView.separated(
                  itemCount: exam.questions.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(
                        height: AppSpacing.md,
                      ),
                  itemBuilder: (context, index) {
                    final question =
                        exam.questions[index];

                    final isCorrect =
                        question.userAnswer ==
                            question.correctAnswer;

                    return Card(
                      child: Padding(
                        padding:
                            const EdgeInsets.all(AppSpacing.lg),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pregunta ${index + 1}",
                              style:
                                  AppTextStyles.subtitle,
                            ),

                            const SizedBox(
                              height: AppSpacing.sm,
                            ),

                            Text(
                              question.statement,
                              style:
                                  AppTextStyles.body,
                            ),

                            const SizedBox(
                              height: AppSpacing.md,
                            ),

                            Text(
                              isCorrect
                                  ? "Correcta"
                                  : "Incorrecta",
                              style: TextStyle(
                                color: isCorrect
                                    ? AppColors.success
                                    : AppColors.error,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            const SizedBox(
                              height: AppSpacing.sm,
                            ),

                            Text(
                              "Tu respuesta: "
                              "${question.userAnswer ?? 'Sin responder'}",
                            ),

                            Text(
                              "Respuesta correcta: "
                              "${question.correctAnswer}",
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}