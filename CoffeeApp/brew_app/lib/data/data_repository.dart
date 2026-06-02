// ==========================================
// 数据仓库模块
// 职责：管理产品、轮播、咖啡卡片等业务数据，支持本地文件覆盖默认值
// ==========================================

import 'package:flutter/material.dart';
import '../core/local_data.dart';
import '../core/default_data.dart';

class DataRepository extends ChangeNotifier {
  List<Map<String, dynamic>> _products =
      List<Map<String, dynamic>>.from(DefaultData.products);
  List<Map<String, dynamic>> _banners =
      List<Map<String, dynamic>>.from(DefaultData.banners);
  List<Map<String, dynamic>> _coffeeCards =
      List<Map<String, dynamic>>.from(DefaultData.coffeeCards);

  List<Map<String, dynamic>> get products => _products;
  List<Map<String, dynamic>> get banners => _banners;
  List<Map<String, dynamic>> get coffeeCards => _coffeeCards;

  /// 将本地 JSON 数据合并到默认数据中
  /// - 同 ID：以本地数据覆盖对应字段
  /// - 新增 ID：追加到列表中
  static List<Map<String, dynamic>> merge(
      List<Map<String, dynamic>> defaults, dynamic overrideData) {
    if (overrideData == null) return List<Map<String, dynamic>>.from(defaults);
    final list = (overrideData is List) ? overrideData : [];
    if (list.isEmpty) return List<Map<String, dynamic>>.from(defaults);

    final result = <Map<String, dynamic>>[];
    final omap = <String, Map<String, dynamic>>{};
    for (final item in list) {
      if (item is Map<String, dynamic> && item['id'] != null) {
        omap[item['id'].toString()] = item;
      }
    }

    for (final def in defaults) {
      final id = def['id'].toString();
      if (omap.containsKey(id)) {
        final merged = Map<String, dynamic>.from(def);
        omap[id]!.forEach((k, v) {
          merged[k] = v;
        });
        result.add(merged);
      } else {
        result.add(Map<String, dynamic>.from(def));
      }
    }

    for (final e in omap.entries) {
      if (!defaults.any((d) => d['id'].toString() == e.key)) {
        result.add(e.value);
      }
    }
    return result;
  }

  /// 从本地磁盘加载数据并合并到默认数据
  Future<void> loadFromDisk() async {
    final [pj, bj, cj] = await Future.wait([
      LocalData.readJson('products.json'),
      LocalData.readJson('banners.json'),
      LocalData.readJson('coffee_cards.json'),
    ]);
    _products = merge(DefaultData.products, pj);
    _banners = merge(DefaultData.banners, bj);
    _coffeeCards = merge(DefaultData.coffeeCards, cj);
    notifyListeners();
  }
}
