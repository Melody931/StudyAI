import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_spacing.dart';

/// Define el estilo global de los botones elevados de StudyAI.
class AppButtonTheme {
  // Constructor privado para impedir instancias.
  AppButtonTheme._();

  /// Tema para todos los ElevatedButton de la aplicación.
  static final ElevatedButtonThemeData elevatedButtonTheme =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,

      elevation: 2,

      minimumSize: const Size(
        double.infinity,
        56,
      ),

      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  );
}