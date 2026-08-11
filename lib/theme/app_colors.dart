import 'package:flutter/material.dart';

/// Contiene todos los colores oficiales de StudyAI.
///
/// Tener todos los colores en un solo lugar facilita
/// mantener una identidad visual consistente y permite
/// cambiar la apariencia de toda la aplicación modificando
/// únicamente este archivo.
class AppColors {
  // Constructor privado para evitar crear instancias.
  AppColors._();

  /// Color principal de la aplicación.
  static const Color primary = Color(0xFF2563EB);

  /// Color secundario utilizado para detalles y acentos.
  static const Color secondary = Color(0xFF06B6D4);

  /// Fondo general de la aplicación.
  static const Color background = Color(0xFFF8FAFC);

  /// Color de las tarjetas.
  static const Color surface = Color(0xFFFFFFFF);

  /// Color principal del texto.
  static const Color textPrimary = Color(0xFF1E293B);

  /// Color para textos secundarios.
  static const Color textSecondary = Color(0xFF64748B);

  /// Color para acciones correctas o estados positivos.
  static const Color success = Color(0xFF22C55E);

  /// Color para errores.
  static const Color error = Color(0xFFEF4444);

  /// Color de bordes suaves.
  static const Color border = Color(0xFFE2E8F0);
}