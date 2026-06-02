// ==========================================
// App 根组件模块
// 职责：创建全局状态实例 · MaterialApp 配置 · 登录/主页路由切换
// ==========================================

import 'package:flutter/material.dart';
import 'core/design_system.dart';
import 'state/auth_state.dart';
import 'state/favorites_state.dart';
import 'data/data_repository.dart';
import 'pages/login_page.dart';
import 'navigation/main_navigation.dart';

class BrewApp extends StatefulWidget {
  const BrewApp({Key? key}) : super(key: key);

  @override
  State<BrewApp> createState() => _BrewAppState();
}

class _BrewAppState extends State<BrewApp> {
  final _auth = AuthState();
  final _fav = FavoritesState();
  final _repo = DataRepository();

  @override
  void dispose() {
    _auth.dispose();
    _fav.dispose();
    _repo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Brew',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppColors.primary,
          scaffoldBackgroundColor: AppColors.canvas,
        ),
        home: ListenableBuilder(
          listenable: _auth,
          builder: (_, __) => _auth.isLoggedIn
              ? MainNavigation(auth: _auth, fav: _fav, repo: _repo)
              : LoginPage(authState: _auth),
        ),
      );
}
