// ==========================================
// 认证状态模块
// 职责：管理用户登录/登出状态及手机号信息
// ==========================================

import 'package:flutter/material.dart';

class AuthState extends ChangeNotifier {
  bool _isLoggedIn = false;
  String _phoneNumber = '';

  bool get isLoggedIn => _isLoggedIn;
  String get phoneNumber => _phoneNumber;

  void login(String phone) {
    _isLoggedIn = true;
    _phoneNumber = phone;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    _phoneNumber = '';
    notifyListeners();
  }
}
