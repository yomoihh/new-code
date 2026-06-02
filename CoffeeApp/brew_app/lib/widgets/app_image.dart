// ==========================================
// 图片组件模块
// 职责：从本地上传目录异步加载并展示图片，支持占位和回退
// ==========================================

import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../core/local_data.dart';
import '../core/design_system.dart';

class AppImage extends StatelessWidget {
  final String? filename;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double borderRadius;
  final Color? placeholderColor;
  final Widget? fallback;

  const AppImage({
    Key? key,
    this.filename,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = 0,
    this.placeholderColor,
    this.fallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: _ImageLoader(
          filename: filename,
          width: width,
          height: height,
          fit: fit,
          placeholderColor:
              placeholderColor ?? AppColors.canvasParchment,
          fallback: fallback ??
              const Icon(Icons.coffee, size: 48, color: AppColors.inkMuted48),
        ),
      );
}

class _ImageLoader extends StatefulWidget {
  final String? filename;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color placeholderColor;
  final Widget fallback;

  const _ImageLoader({
    Key? key,
    required this.filename,
    this.width,
    this.height,
    required this.fit,
    required this.placeholderColor,
    required this.fallback,
  }) : super(key: key);

  @override
  State<_ImageLoader> createState() => _ImageLoaderState();
}

class _ImageLoaderState extends State<_ImageLoader> {
  Uint8List? _bytes;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void didUpdateWidget(_ImageLoader old) {
    super.didUpdateWidget(old);
    if (old.filename != widget.filename) {
      _bytes = null;
      _loading = true;
      _load();
    }
  }

  Future<void> _load() async {
    final fn = widget.filename;
    if (fn == null || fn.isEmpty) {
      if (mounted) setState(() => _loading = false);
      return;
    }
    final bytes = await LocalData.readImage(fn);
    if (mounted) setState(() {
          _bytes = bytes;
          _loading = false;
        });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Container(
        color: widget.placeholderColor,
        width: widget.width,
        height: widget.height,
        child: const Center(
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }
    if (_bytes != null) {
      return Image.memory(_bytes!,
          width: widget.width, height: widget.height, fit: widget.fit);
    }
    return Container(
      color: widget.placeholderColor,
      width: widget.width,
      height: widget.height,
      child: Center(child: widget.fallback),
    );
  }
}
