import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import 'generateExamScreen.dart';

/// Pantalla principal de StudyAI.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StudyAI'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.school_rounded,
                size: 90,
              ),

              const SizedBox(height: AppSpacing.xl),

              Text(
                'StudyAI',
                style: AppTextStyles.headline,
              ),

              const SizedBox(height: AppSpacing.sm),

              Text(
                'Genera exámenes personalizados con ayuda de inteligencia artificial.',
                textAlign: TextAlign.center,
                style: AppTextStyles.subtitle,
              ),

              const SizedBox(height: AppSpacing.xxl),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const GenerateExamScreen(),
                      ),
                    );
                  },
                  child: const Text('Crear examen'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}