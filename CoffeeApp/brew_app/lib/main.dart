// ==========================================
// Brew 咖啡 App — 主入口
// 所有功能模块独立拆分，统一通过此文件导入调用
// ==========================================
//
// 项目结构:
//   lib/
//   ├── main.dart                       ← 入口（当前文件）
//   ├── app.dart                        ← App 根组件
//   ├── core/
//   │   ├── local_data.dart             ← 本地文件读写
//   │   ├── design_system.dart          ← 颜色/排版/间距/圆角
//   │   └── default_data.dart           ← 默认业务数据
//   ├── data/
//   │   └── data_repository.dart        ← 数据仓库（合并本地覆盖）
//   ├── state/
//   │   ├── auth_state.dart             ← 认证状态
//   │   └── favorites_state.dart        ← 收藏状态
//   ├── widgets/
//   │   ├── app_image.dart              ← 异步图片组件
//   │   ├── primary_button.dart         ← 主按钮组件
//   │   ├── secondary_button.dart       ← 次级按钮组件
//   │   └── product_card.dart           ← 产品卡片组件
//   ├── pages/
//   │   ├── login_page.dart             ← 登录页
//   │   ├── home_page.dart              ← 首页
//   │   ├── shop_page.dart              ← 商城页
//   │   └── profile_page.dart           ← 个人中心页
//   └── navigation/
//       └── main_navigation.dart        ← 底部导航
//
// ==========================================

import 'package:flutter/material.dart';
import 'app.dart';

void main() => runApp(const BrewApp());
