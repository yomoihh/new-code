// ==========================================
// 主按钮组件模块
// 职责：品牌主色调填充按钮，支持加载态和按压缩放动效
// ==========================================

import 'package:flutter/material.dart';
import '../core/design_system.dart';

class PrimaryButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final bool loading;

  const PrimaryButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.width,
    this.loading = false,
  }) : super(key: key);

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTapDown:
            widget.loading ? null : (_) => setState(() => _scale = 0.95),
        onTapUp: widget.loading
            ? null
            : (_) {
                setState(() => _scale = 1.0);
                widget.onPressed?.call();
              },
        onTapCancel: () => setState(() => _scale = 1.0),
        child: AnimatedScale(
          scale: _scale,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
          child: Container(
            width: widget.width,
            height: 48,
            padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
            child: Center(
              child: widget.loading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.canvas,
                      ),
                    )
                  : Text(
                      widget.text,
                      style: AppTypography.buttonLarge
                          .copyWith(color: AppColors.canvas),
                    ),
            ),
          ),
        ),
      );
}
