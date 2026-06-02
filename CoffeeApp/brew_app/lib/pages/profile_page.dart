// ==========================================
// 个人中心页面模块
// 职责：用户信息卡片 · 收藏展示 · 菜单入口 · 退出登录
// ==========================================

import 'package:flutter/material.dart';
import '../core/design_system.dart';
import '../data/data_repository.dart';
import '../state/auth_state.dart';
import '../state/favorites_state.dart';
import '../widgets/app_image.dart';
import '../widgets/secondary_button.dart';
import '../navigation/main_navigation.dart';

class ProfilePage extends StatelessWidget {
  final AuthState auth;
  final FavoritesState fav;
  final DataRepository dataRepo;

  const ProfilePage({
    Key? key,
    required this.auth,
    required this.fav,
    required this.dataRepo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.canvas,
        appBar: AppBar(
          backgroundColor: AppColors.surfaceDark1,
          elevation: 0,
          toolbarHeight: 44,
          centerTitle: true,
          title: Text(
            '我的',
            style: AppTypography.caption.copyWith(
                color: AppColors.inkOnDark,
                fontSize: 15,
                fontWeight: FontWeight.w600),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _userCard(),
              const SizedBox(height: AppSpacing.lg),
              _stats(context),
              const SizedBox(height: AppSpacing.lg),
              _favSection(context),
              const SizedBox(height: AppSpacing.lg),
              _menu(context),
              const SizedBox(height: AppSpacing.lg),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: SizedBox(
                  width: double.infinity,
                  child: SecondaryButton(
                    text: '退出登录',
                    onPressed: () => _logout(context),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),
            ],
          ),
        ),
      );

  // ---- 用户信息卡片 ----

  Widget _userCard() => Container(
        width: double.infinity,
        margin:
            const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.md, AppSpacing.md, 0),
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.surfaceDark1,
          borderRadius: BorderRadius.circular(AppRadius.xl),
        ),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(AppRadius.xl),
              ),
              child: Center(
                child: Icon(Icons.phone_android,
                    size: 28, color: AppColors.canvas),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    auth.phoneNumber,
                    style: AppTypography.tagline
                        .copyWith(color: AppColors.inkOnDark),
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    '已通过手机号登录',
                    style: AppTypography.caption
                        .copyWith(color: AppColors.inkOnDark48),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right,
                color: AppColors.inkOnDark, size: 20),
          ],
        ),
      );

  // ---- 统计区域 ----

  Widget _stats(BuildContext context) => ListenableBuilder(
        listenable: fav,
        builder: (_, __) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Row(
            children: [
              _statItem('收藏', '${fav.count}', Icons.favorite_outlined),
              const SizedBox(width: AppSpacing.sm),
              _statItem('订单', '0', Icons.receipt_long_outlined),
              const SizedBox(width: AppSpacing.sm),
              _statItem('优惠券', '3', Icons.card_giftcard_outlined),
            ],
          ),
        ),
      );

  Widget _statItem(String label, String value, IconData icon) => Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.surfaceCard,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: AppColors.hairline),
          ),
          child: Column(
            children: [
              Icon(icon, size: 22, color: AppColors.primary),
              const SizedBox(height: AppSpacing.xs),
              Text(
                value,
                style:
                    AppTypography.tagline.copyWith(color: AppColors.ink),
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                label,
                style: AppTypography.caption
                    .copyWith(color: AppColors.inkMuted),
              ),
            ],
          ),
        ),
      );

  // ---- 收藏区域 ----

  Widget _favSection(BuildContext context) => ListenableBuilder(
        listenable: fav,
        builder: (_, __) {
          final fl = fav.favorites.toList();
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.surfaceCard,
              borderRadius: BorderRadius.circular(AppRadius.xl),
              border: Border.all(color: AppColors.hairline),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      AppSpacing.md, AppSpacing.md, AppSpacing.md, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.favorite,
                              size: 18, color: AppColors.error),
                          const SizedBox(width: AppSpacing.xs),
                          Text(
                            '我的收藏',
                            style: AppTypography.bodyStrong
                                .copyWith(color: AppColors.ink),
                          ),
                        ],
                      ),
                      Text(
                        '${fav.count} 件',
                        style: AppTypography.caption
                            .copyWith(color: AppColors.inkMuted),
                      ),
                    ],
                  ),
                ),
                if (fl.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    child: Center(
                      child: Column(
                        children: [
                          const Icon(Icons.favorite_border,
                              size: 36, color: AppColors.inkMuted48),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            '还没有收藏咖啡',
                            style: AppTypography.caption
                                .copyWith(color: AppColors.inkMuted),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          GestureDetector(
                            onTap: () => context
                                .findAncestorStateOfType<
                                    MainNavigationState>()
                                ?.switchToTab(1),
                            child: Text(
                              '去商城逛逛',
                              style: AppTypography.caption.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  SizedBox(
                    height: 180,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.all(AppSpacing.md),
                      itemCount: fl.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(width: AppSpacing.sm),
                      itemBuilder: (ctx, i) {
                        final n = fl[i];
                        final m = dataRepo.products
                            .where((p) => p['name'] == n);
                        final info = m.isNotEmpty
                            ? m.first
                            : <String, dynamic>{
                                'name': n,
                                'price': '¥--',
                                'image': ''
                              };
                        return SizedBox(
                          width: 140,
                          child: Material(
                            color: AppColors.canvasParchment,
                            borderRadius:
                                BorderRadius.circular(AppRadius.md),
                            child: InkWell(
                              borderRadius:
                                  BorderRadius.circular(AppRadius.md),
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(AppSpacing.xs),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          AppRadius.sm),
                                      child: AspectRatio(
                                        aspectRatio: 1,
                                        child: AppImage(
                                            filename:
                                                info['image'] as String?),
                                      ),
                                    ),
                                    const SizedBox(height: AppSpacing.xs),
                                    Text(
                                      info['name'] as String? ?? '',
                                      style: AppTypography.caption.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.ink),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 2),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          info['price'] as String? ?? '',
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: AppColors.inkMuted),
                                        ),
                                        GestureDetector(
                                          onTap: () => fav.remove(n),
                                          child: const Icon(Icons.close,
                                              size: 14,
                                              color: AppColors.inkMuted48),
                                        ),
                                      ],
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
              ],
            ),
          );
        },
      );

  // ---- 功能菜单 ----

  Widget _menu(BuildContext context) {
    final items = [
      {
        'icon': Icons.shopping_bag_outlined,
        'title': '我的订单',
        'sub': '查看全部订单',
      },
      {
        'icon': Icons.location_on_outlined,
        'title': '收货地址',
        'sub': '管理配送地址',
      },
      {
        'icon': Icons.card_giftcard_outlined,
        'title': '优惠券',
        'sub': '3 张可用',
      },
      {
        'icon': Icons.notifications_outlined,
        'title': '消息通知',
        'sub': '订单与促销消息',
      },
      {
        'icon': Icons.settings_outlined,
        'title': '设置',
        'sub': '账号与偏好设置',
      },
      {
        'icon': Icons.help_outline,
        'title': '帮助与反馈',
        'sub': '常见问题与客服',
      },
    ];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: AppColors.hairline),
      ),
      child: Column(
        children: items.asMap().entries.map((e) {
          final it = e.value;
          final last = e.key == items.length - 1;
          return Column(
            children: [
              ListTile(
                leading: Icon(it['icon'] as IconData,
                    color: AppColors.primary, size: 22),
                title: Text(
                  it['title'] as String,
                  style: AppTypography.bodyStrong
                      .copyWith(color: AppColors.ink),
                ),
                subtitle: Text(
                  it['sub'] as String,
                  style: AppTypography.caption
                      .copyWith(color: AppColors.inkMuted),
                ),
                trailing: const Icon(Icons.chevron_right,
                    color: AppColors.inkMuted48, size: 20),
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${it['title']}功能开发中'),
                    backgroundColor: AppColors.surfaceDark1,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                  ),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              ),
              if (!last)
                const Divider(
                  color: AppColors.divider,
                  height: 1,
                  indent: AppSpacing.lg + AppSpacing.md + 22,
                  endIndent: AppSpacing.md,
                ),
            ],
          );
        }).toList(),
      ),
    );
  }

  // ---- 退出登录 ----

  void _logout(BuildContext context) => showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: AppColors.surfaceCard,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.xl),
          ),
          title: Text(
            '确认退出',
            style: AppTypography.tagline.copyWith(color: AppColors.ink),
          ),
          content: Text(
            '退出后需重新登录',
            style: AppTypography.body.copyWith(color: AppColors.inkMuted),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(
                '取消',
                style: AppTypography.bodyStrong
                    .copyWith(color: AppColors.inkMuted),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                auth.logout();
              },
              child: Text(
                '退出',
                style: AppTypography.bodyStrong
                    .copyWith(color: AppColors.error),
              ),
            ),
          ],
        ),
      );
}
