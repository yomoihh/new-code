// ==========================================
// 首页模块
// 职责：轮播 Banner + 咖啡产地卡片网格展示
// ==========================================

import 'dart:async';
import 'package:flutter/material.dart';
import '../core/design_system.dart';
import '../data/data_repository.dart';
import '../widgets/app_image.dart';
import '../navigation/main_navigation.dart';

class HomePage extends StatefulWidget {
  final DataRepository dataRepo;

  const HomePage({Key? key, required this.dataRepo}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageCtrl = PageController();
  int _current = 0;
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (t) {
      final b = widget.dataRepo.banners;
      if (b.isNotEmpty && _pageCtrl.hasClients) {
        _pageCtrl.animateToPage(
          (_current + 1) % b.length,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageCtrl.dispose();
    super.dispose();
  }

  Color _parseColor(String hex) {
    try {
      return Color(
          int.parse('FF${hex.replaceFirst('#', '')}', radix: 16));
    } catch (_) {
      return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) =>
      ListenableBuilder(
        listenable: widget.dataRepo,
        builder: (_, __) {
          final banners = widget.dataRepo.banners;
          final cards = widget.dataRepo.coffeeCards;
          return Scaffold(
            backgroundColor: AppColors.canvas,
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: AppColors.surfaceDark1,
                  pinned: true,
                  elevation: 0,
                  toolbarHeight: 44,
                  centerTitle: true,
                  title: Text(
                    'Brew',
                    style: AppTypography.caption.copyWith(
                        color: AppColors.inkOnDark,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SliverToBoxAdapter(child: _carousel(banners)),
                SliverToBoxAdapter(child: _sectionHeader(context)),
                if (cards.isEmpty)
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(AppSpacing.xxl),
                      child: Center(
                        child: Text(
                          '暂无咖啡数据',
                          style: TextStyle(color: AppColors.inkMuted),
                        ),
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.68,
                        crossAxisSpacing: AppSpacing.sm,
                        mainAxisSpacing: AppSpacing.sm,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (ctx, i) => _card(cards[i]),
                        childCount: cards.length,
                      ),
                    ),
                  ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.all(AppSpacing.md),
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2D5016).withOpacity(0.06),
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.eco_outlined,
                            size: 18, color: Color(0xFF2D5016)),
                        SizedBox(width: AppSpacing.xs),
                        Expanded(
                          child: Text(
                            '2030 碳中和承诺 · 让每杯咖啡都对地球更友好',
                            style: TextStyle(
                                fontSize: 13, color: Color(0xFF2D5016)),
                          ),
                        ),
                        Icon(Icons.chevron_right,
                            size: 16, color: Color(0xFF2D5016)),
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                    child: SizedBox(height: AppSpacing.md)),
              ],
            ),
          );
        },
      );

  // ---- 轮播 ----

  Widget _carousel(List<Map<String, dynamic>> list) {
    if (list.isEmpty) {
      return const SizedBox(
        height: 300,
        child: Center(child: Text('暂无轮播')),
      );
    }
    return Column(
      children: [
        SizedBox(
          height: 300,
          child: PageView.builder(
            controller: _pageCtrl,
            itemCount: list.length,
            onPageChanged: (i) => setState(() => _current = i),
            itemBuilder: (ctx, i) {
              final b = list[i];
              final img = b['image'] as String? ?? '';
              final grads = (b['gradient'] is List
                  ? (b['gradient'] as List)
                      .map((c) => _parseColor(c.toString()))
                      .toList()
                  : <Color>[AppColors.primary, AppColors.primaryDark]);
              return Padding(
                padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md, AppSpacing.sm, AppSpacing.md, AppSpacing.xs),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(AppRadius.xl),
                    onTap: () {},
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppRadius.xl),
                        boxShadow: [
                          BoxShadow(
                            color: grads.last.withOpacity(0.4),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(AppRadius.xl),
                            child: img.isNotEmpty
                                ? ColorFiltered(
                                    colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.35),
                                        BlendMode.darken),
                                    child: AppImage(
                                        filename: img, fit: BoxFit.cover),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: grads,
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                    ),
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(AppSpacing.xl),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius:
                                        BorderRadius.circular(AppRadius.pill),
                                  ),
                                  child: Text(
                                    b['tag'] as String? ?? '',
                                    style: AppTypography.caption.copyWith(
                                        color: AppColors.inkOnDark,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.md),
                                Text(
                                  b['title'] as String? ?? '',
                                  style: AppTypography.displayLg
                                      .copyWith(color: AppColors.inkOnDark),
                                ),
                                const SizedBox(height: AppSpacing.xs),
                                Text(
                                  b['subtitle'] as String? ?? '',
                                  style: AppTypography.body.copyWith(
                                      color: AppColors.inkOnDark
                                          .withOpacity(0.75)),
                                ),
                                const SizedBox(height: AppSpacing.md),
                                const Row(
                                  children: [
                                    Text(
                                      '立即探索',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.inkOnDark),
                                    ),
                                    SizedBox(width: 4),
                                    Icon(Icons.arrow_forward,
                                        color: AppColors.inkOnDark, size: 18),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            list.length,
            (i) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: i == _current ? 24 : 8,
              height: 8,
              decoration: BoxDecoration(
                color:
                    i == _current ? AppColors.primary : AppColors.hairline,
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ---- 分区标题 ----

  Widget _sectionHeader(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(
            AppSpacing.md, AppSpacing.xl, AppSpacing.md, AppSpacing.sm),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '探索产地风味',
              style: AppTypography.tagline.copyWith(color: AppColors.ink),
            ),
            GestureDetector(
              onTap: () => context
                  .findAncestorStateOfType<MainNavigationState>()
                  ?.switchToTab(1),
              child: const Row(
                children: [
                  Text(
                    '查看全部',
                    style: TextStyle(fontSize: 13, color: AppColors.primary),
                  ),
                  SizedBox(width: 2),
                  Icon(Icons.chevron_right,
                      color: AppColors.primary, size: 16),
                ],
              ),
            ),
          ],
        ),
      );

  // ---- 咖啡产地卡片 ----

  Widget _card(Map<String, dynamic> c) => Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.xl),
          onTap: () {},
          child: Ink(
            decoration: BoxDecoration(
              color: AppColors.surfaceCard,
              borderRadius: BorderRadius.circular(AppRadius.xl),
              border: Border.all(color: AppColors.hairline),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(AppRadius.xl)),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        AppImage(
                            filename: c['image'] as String?,
                            borderRadius: 0),
                        Positioned(
                          left: 12,
                          top: 10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius:
                                  BorderRadius.circular(AppRadius.pill),
                            ),
                            child: Text(
                              c['roast'] as String? ?? '',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          c['name'] as String? ?? '',
                          style: AppTypography.caption.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.ink,
                              height: 1.3),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Expanded(
                          child: Text(
                            c['desc'] as String? ?? '',
                            style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                color: AppColors.inkMuted,
                                height: 1.4),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.location_on_outlined,
                                size: 12, color: AppColors.inkMuted48),
                            const SizedBox(width: 2),
                            Expanded(
                              child: Text(
                                c['origin'] as String? ?? '',
                                style: const TextStyle(
                                    fontSize: 10,
                                    color: AppColors.inkMuted48),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
