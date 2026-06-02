// ==========================================
// 产品卡片组件模块
// 职责：展示产品名称、价格、图片及收藏状态，支持点击和收藏切换
// ==========================================

import 'package:flutter/material.dart';
import '../core/design_system.dart';
import 'app_image.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final String price;
  final String? imageFile;
  final bool isFavorited;
  final VoidCallback? onTap;
  final VoidCallback? onToggleFavorite;

  const ProductCard({
    Key? key,
    required this.name,
    required this.price,
    this.imageFile,
    this.isFavorited = false,
    this.onTap,
    this.onToggleFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Material(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          onTap: onTap,
          splashColor: AppColors.primary.withOpacity(0.1),
          highlightColor: AppColors.primary.withOpacity(0.05),
          child: Ink(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.hairline),
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: AppImage(filename: imageFile),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: _FavBtn(
                        isFavorited: isFavorited,
                        onTap: onToggleFavorite,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  name,
                  style: AppTypography.bodyStrong
                      .copyWith(color: AppColors.ink),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style:
                      AppTypography.body.copyWith(color: AppColors.inkMuted),
                ),
              ],
            ),
          ),
        ),
      );
}

// ---- 收藏按钮（私有，仅供 ProductCard 使用） ----

class _FavBtn extends StatefulWidget {
  final bool isFavorited;
  final VoidCallback? onTap;

  const _FavBtn({Key? key, required this.isFavorited, this.onTap})
      : super(key: key);

  @override
  State<_FavBtn> createState() => _FavBtnState();
}

class _FavBtnState extends State<_FavBtn>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl = AnimationController(
      duration: const Duration(milliseconds: 200), vsync: this);
  late Animation<double> _anim = Tween<double>(begin: 1.0, end: 1.35)
      .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutBack));

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _tap() {
    _ctrl.forward().then((_) => _ctrl.reverse());
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: _tap,
        child: ScaleTransition(
          scale: _anim,
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.surfaceCard.withOpacity(0.9),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              widget.isFavorited
                  ? Icons.favorite
                  : Icons.favorite_border,
              size: 16,
              color: widget.isFavorited
                  ? AppColors.error
                  : AppColors.inkMuted,
            ),
          ),
        ),
      );
}
