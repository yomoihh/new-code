// ==========================================
// 收藏状态模块
// 职责：管理用户收藏的咖啡产品集合
// ==========================================

import 'package:flutter/material.dart';

class FavoritesState extends ChangeNotifier {
  final Set<String> _favs = {};

  Set<String> get favorites => _favs;
  int get count => _favs.length;

  bool isFavorite(String name) => _favs.contains(name);

  void toggle(String name) {
    if (_favs.contains(name)) {
      _favs.remove(name);
    } else {
      _favs.add(name);
    }
    notifyListeners();
  }

  void remove(String name) {
    _favs.remove(name);
    notifyListeners();
  }
}
