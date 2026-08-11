import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Contiene todos los estilos de texto oficiales de StudyAI.
///
/// Centralizar la tipografía garantiza que toda la aplicación
/// mantenga una apariencia consistente.
class AppTextStyles {
  // Constructor privado para impedir instancias.
  AppTextStyles._();

  /// Título principal de la aplicación.
  static const TextStyle headline = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  /// Títulos de secciones.
  static const TextStyle title = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  /// Subtítulos.
  static const TextStyle subtitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  /// Texto principal.
  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  /// Texto secundario.
  static const TextStyle bodySecondary = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  /// Texto de botones.
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}