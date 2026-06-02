// ==========================================
// 商城页面模块
// 职责：搜索 + 分类筛选 + 产品网格展示，支持收藏切换
// ==========================================

import 'package:flutter/material.dart';
import '../core/design_system.dart';
import '../data/data_repository.dart';
import '../state/favorites_state.dart';
import '../widgets/product_card.dart';

class ShopPage extends StatefulWidget {
  final FavoritesState fav;
  final DataRepository dataRepo;

  const ShopPage({
    Key? key,
    required this.fav,
    required this.dataRepo,
  }) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  String _q = '';
  String _cat = '全部';
  static const _cats = ['全部', '非洲', '南美', '亚洲', '中美'];

  List<Map<String, dynamic>> get _filtered {
    var l = widget.dataRepo.products;
    if (_cat != '全部') {
      l = l.where((p) => p['category'] == _cat).toList();
    }
    if (_q.isNotEmpty) {
      l = l
          .where((p) => (p['name'] ?? '')
              .toString()
              .toLowerCase()
              .contains(_q.toLowerCase()))
          .toList();
    }
    return l;
  }

  @override
  Widget build(BuildContext context) =>
      ListenableBuilder(
        listenable: widget.dataRepo,
        builder: (_, __) {
          final filtered = _filtered;
          return Scaffold(
            backgroundColor: AppColors.canvas,
            appBar: AppBar(
              backgroundColor: AppColors.surfaceDark1,
              elevation: 0,
              toolbarHeight: 44,
              centerTitle: true,
              title: Text(
                '商城',
                style: AppTypography.caption.copyWith(
                    color: AppColors.inkOnDark,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
            ),
            body: Column(
              children: [
                // 搜索框
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      AppSpacing.md, AppSpacing.md, AppSpacing.md, AppSpacing.sm),
                  child: Container(
                    height: 44,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: AppColors.canvas,
                      border: Border.all(color: AppColors.hairline),
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search,
                            size: 18, color: AppColors.inkMuted),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            onChanged: (v) => setState(() => _q = v),
                            decoration: InputDecoration(
                              hintText: '搜索咖啡豆...',
                              hintStyle: AppTypography.body
                                  .copyWith(color: AppColors.inkMuted),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              isDense: true,
                            ),
                            style: AppTypography.body,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // 分类标签
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                    itemCount: _cats.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(width: AppSpacing.xs),
                    itemBuilder: (ctx, i) {
                      final s = _cats[i] == _cat;
                      return GestureDetector(
                        onTap: () => setState(() => _cat = _cats[i]),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: s
                                ? AppColors.primary
                                : AppColors.surfaceCard,
                            borderRadius:
                                BorderRadius.circular(AppRadius.pill),
                            border: Border.all(
                              color: s
                                  ? AppColors.primary
                                  : AppColors.hairline,
                            ),
                          ),
                          child: Text(
                            _cats[i],
                            style: AppTypography.caption.copyWith(
                              color: s
                                  ? AppColors.canvas
                                  : AppColors.inkMuted,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                // 结果计数
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  child: Row(
                    children: [
                      Text(
                        '共 ${filtered.length} 款产品',
                        style: AppTypography.caption
                            .copyWith(color: AppColors.inkMuted),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                // 产品网格
                Expanded(
                  child: filtered.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.search_off,
                                  size: 48, color: AppColors.inkMuted48),
                              const SizedBox(height: AppSpacing.md),
                              Text(
                                '没有找到相关产品',
                                style: AppTypography.body
                                    .copyWith(color: AppColors.inkMuted),
                              ),
                            ],
                          ),
                        )
                      : GridView.builder(
                          padding: const EdgeInsets.all(AppSpacing.md),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.72,
                            crossAxisSpacing: AppSpacing.md,
                            mainAxisSpacing: AppSpacing.md,
                          ),
                          itemCount: filtered.length,
                          itemBuilder: (ctx, i) {
                            final p = filtered[i];
                            final n = p['name'] as String? ?? '';
                            return ProductCard(
                              name: n,
                              price: p['price'] as String? ?? '',
                              imageFile: p['image'] as String?,
                              isFavorited: widget.fav.isFavorite(n),
                              onToggleFavorite: () => widget.fav.toggle(n),
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      );
}
