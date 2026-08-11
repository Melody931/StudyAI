// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../services/ai_service.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import 'exam_screen.dart';

class GenerateExamScreen extends StatefulWidget {
  const GenerateExamScreen({super.key});

  @override
  State<GenerateExamScreen> createState() => _GenerateExamScreenState();
}

class _GenerateExamScreenState extends State<GenerateExamScreen> {
  final TextEditingController topicController = TextEditingController();
  final TextEditingController questionCountController =
      TextEditingController();

  final AiService aiService = AiService();

  /// Cantidad máxima de preguntas permitidas.
  static const int maxQuestions = 50;

  String selectedDifficulty = "Intermedio";

  bool isLoading = false;

  @override
  void dispose() {
    topicController.dispose();
    questionCountController.dispose();
    super.dispose();
  }

  Future<void> generateExam() async {
    final topic = topicController.text.trim();

    if (topic.isEmpty) {
      showMessage("Escribe un tema para el examen.");
      return;
    }

    final questionCount =
        int.tryParse(questionCountController.text.trim());

    if (questionCount == null || questionCount <= 0) {
      showMessage("Introduce una cantidad válida de preguntas.");
      return;
    }

    if (questionCount > maxQuestions) {
      showMessage(
        "La cantidad máxima permitida es de $maxQuestions preguntas.",
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final exam = await aiService.generateExam(
        topic: topic,
        difficulty: selectedDifficulty,
        questionCount: questionCount,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ExamScreen(
            exam: exam,
          ),
        ),
      );
    } catch (_) {
      showMessage(
        "No fue posible generar el examen. Comprueba tu conexión e inténtalo nuevamente.",
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Generar examen"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.quiz_rounded,
                size: 80,
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                "Configura tu examen",
                textAlign: TextAlign.center,
                style: AppTextStyles.title,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                "Elige el tema, la dificultad y la cantidad de preguntas que deseas generar.",
                textAlign: TextAlign.center,
                style: AppTextStyles.bodySecondary,
              ),
              const SizedBox(height: AppSpacing.xxl),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    children: [
                      TextField(
                        controller: topicController,
                        enabled: !isLoading,
                        maxLength: 100,
                        decoration: const InputDecoration(
                          labelText: "Tema",
                          hintText: "Ejemplo: Historia",
                          prefixIcon: Icon(Icons.menu_book_rounded),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      DropdownButtonFormField<String>(
                        initialValue: selectedDifficulty,
                        decoration: const InputDecoration(
                          labelText: "Dificultad",
                          prefixIcon: Icon(Icons.bar_chart_rounded),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: "Principiante",
                            child: Text("Principiante"),
                          ),
                          DropdownMenuItem(
                            value: "Intermedio",
                            child: Text("Intermedio"),
                          ),
                          DropdownMenuItem(
                            value: "Experto",
                            child: Text("Experto"),
                          ),
                        ],
                        onChanged: isLoading
                            ? null
                            : (value) {
                                setState(() {
                                  selectedDifficulty = value!;
                                });
                              },
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      TextField(
                        controller: questionCountController,
                        enabled: !isLoading,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Cantidad de preguntas",
                          hintText: "Máximo $maxQuestions",
                          prefixIcon:
                              const Icon(Icons.format_list_numbered),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),
              ElevatedButton(
                onPressed: isLoading ? null : generateExam,
                child: isLoading
                    ? const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          color: Colors.white,
                        ),
                      )
                    : const Text("Generar examen"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}