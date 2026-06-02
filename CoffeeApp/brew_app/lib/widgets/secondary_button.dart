// ==========================================
// 次级按钮组件模块
// 职责：描边样式按钮，用于次要操作（如退出登录），支持按压缩放动效
// ==========================================

import 'package:flutter/material.dart';
import '../core/design_system.dart';

class SecondaryButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;

  const SecondaryButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.width,
  }) : super(key: key);

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTapDown: (_) => setState(() => _scale = 0.95),
        onTapUp: (_) {
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
              color: Colors.transparent,
              border: Border.all(color: AppColors.primary, width: 1),
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
            child: Center(
              child: Text(
                widget.text,
                style: AppTypography.buttonLarge
                    .copyWith(color: AppColors.primary),
              ),
            ),
          ),
        ),
      );
}
