// ==========================================
// 设计系统模块
// 职责：统一管理颜色、排版、间距、圆角等视觉常量
// ==========================================

import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF6B4423);
  static const primaryDark = Color(0xFF4A2F19);
  static const primaryLight = Color(0xFF8B5E34);
  static const canvas = Color(0xFFFFFBF7);
  static const canvasParchment = Color(0xFFF5F1EB);
  static const surfaceDark1 = Color(0xFF2C2420);
  static const surfaceDark2 = Color(0xFF342A25);
  static const surfaceCard = Color(0xFFFFFFFF);
  static const ink = Color(0xFF2A2520);
  static const inkOnDark = Color(0xFFFFFBF7);
  static const inkOnDark48 = Color(0x7AFFFBF7);
  static const inkMuted = Color(0xFF8A7D75);
  static const inkMuted48 = Color(0xFFB8ADA5);
  static const divider = Color(0xFFE8E1DB);
  static const hairline = Color(0xFFD4CCC4);
  static const error = Color(0xFFD32F2F);
  static const success = Color(0xFF2D5016);
}

class AppTypography {
  static const heroDisplay = TextStyle(
      fontSize: 48,
      fontWeight: FontWeight.w600,
      height: 1.1,
      letterSpacing: -0.5);
  static const displayLg = TextStyle(
      fontSize: 34,
      fontWeight: FontWeight.w600,
      height: 1.15,
      letterSpacing: -0.3);
  static const displayMd = TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      height: 1.2,
      letterSpacing: -0.2);
  static const tagline = TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w600,
      height: 1.25,
      letterSpacing: -0.2);
  static const body = TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w400,
      height: 1.47,
      letterSpacing: -0.3);
  static const bodyStrong = TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w600,
      height: 1.47,
      letterSpacing: -0.3);
  static const caption = TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      height: 1.38,
      letterSpacing: -0.1);
  static const buttonLarge = TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w600,
      height: 1.2,
      letterSpacing: 0);
}

class AppSpacing {
  static const xxs = 4.0;
  static const xs = 8.0;
  static const sm = 12.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
  static const xxl = 48.0;
}

class AppRadius {
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 12.0;
  static const lg = 16.0;
  static const xl = 24.0;
  static const pill = 9999.0;
}
