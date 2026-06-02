// ==========================================
// 主导航模块
// 职责：底部导航栏切换（首页 / 商城 / 我的），收藏角标
// ==========================================

import 'package:flutter/material.dart';
import '../core/design_system.dart';
import '../state/auth_state.dart';
import '../state/favorites_state.dart';
import '../data/data_repository.dart';
import '../pages/home_page.dart';
import '../pages/shop_page.dart';
import '../pages/profile_page.dart';

class MainNavigation extends StatefulWidget {
  final AuthState auth;
  final FavoritesState fav;
  final DataRepository repo;

  const MainNavigation({
    Key? key,
    required this.auth,
    required this.fav,
    required this.repo,
  }) : super(key: key);

  @override
  State<MainNavigation> createState() => MainNavigationState();
}

class MainNavigationState extends State<MainNavigation> {
  int _idx = 0;

  @override
  void initState() {
    super.initState();
    widget.repo.loadFromDisk();
  }

  /// 供外部页面（如首页"查看全部"）调用以切换 Tab
  void switchToTab(int i) => setState(() => _idx = i);

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(dataRepo: widget.repo),
      ShopPage(fav: widget.fav, dataRepo: widget.repo),
      ProfilePage(auth: widget.auth, fav: widget.fav, dataRepo: widget.repo),
    ];

    return Scaffold(
      body: pages[_idx],
      bottomNavigationBar: ListenableBuilder(
        listenable: widget.fav,
        builder: (_, __) {
          final n = widget.fav.count;
          return BottomNavigationBar(
            currentIndex: _idx,
            onTap: (i) => setState(() => _idx = i),
            backgroundColor: AppColors.canvas,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.inkMuted,
            selectedLabelStyle: AppTypography.caption,
            unselectedLabelStyle: AppTypography.caption,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: '首页',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.coffee_outlined),
                activeIcon: Icon(Icons.coffee),
                label: '商城',
              ),
              BottomNavigationBarItem(
                icon: n == 0
                    ? const Icon(Icons.person_outlined)
                    : _badge(Icons.person_outlined, n),
                activeIcon: n == 0
                    ? const Icon(Icons.person)
                    : _badge(Icons.person, n),
                label: '我的',
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _badge(IconData icon, int count) => Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(icon),
          Positioned(
            right: -8,
            top: -4,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                color: AppColors.error,
                shape: BoxShape.circle,
              ),
              constraints:
                  const BoxConstraints(minWidth: 16, minHeight: 16),
              child: Text(
                '$count',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      );
}
