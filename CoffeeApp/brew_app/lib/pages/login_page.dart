// ==========================================
// 登录页面模块
// 职责：手机号输入验证 → 模拟登录 → 进入主界面
// ==========================================

import 'package:flutter/material.dart';
import '../core/design_system.dart';
import '../state/auth_state.dart';
import '../widgets/primary_button.dart';

class LoginPage extends StatefulWidget {
  final AuthState authState;

  const LoginPage({Key? key, required this.authState}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _phoneCtrl = TextEditingController();
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _phoneCtrl.dispose();
    super.dispose();
  }

  bool _isValidPhone(String v) =>
      v.trim().length == 11 && RegExp(r'^1\d{10}$').hasMatch(v.trim());

  void _handleLogin() {
    final phone = _phoneCtrl.text.trim();
    if (!_isValidPhone(phone)) {
      setState(() => _error = '请输入正确的11位手机号码');
      return;
    }
    setState(() {
      _loading = true;
      _error = null;
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      widget.authState.login(phone);
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.canvas,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppSpacing.xxl * 2),
                const Icon(Icons.coffee, size: 64, color: AppColors.primary),
                const SizedBox(height: AppSpacing.md),
                Text(
                  'Brew',
                  style: AppTypography.displayLg
                      .copyWith(color: AppColors.ink),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '享受每一杯的好时光',
                  style: AppTypography.body
                      .copyWith(color: AppColors.inkMuted),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.xxl),
                Text(
                  '手机号码',
                  style: AppTypography.caption
                      .copyWith(color: AppColors.inkMuted),
                ),
                const SizedBox(height: AppSpacing.xs),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.surfaceCard,
                    border: Border.all(color: AppColors.hairline),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Icon(Icons.phone_android,
                            size: 20, color: AppColors.inkMuted),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _phoneCtrl,
                          keyboardType: TextInputType.phone,
                          maxLength: 11,
                          style: AppTypography.body,
                          decoration: const InputDecoration(
                            counterText: '',
                            hintText: '请输入手机号码',
                            hintStyle: TextStyle(
                                fontSize: 17, color: AppColors.inkMuted48),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 14),
                          ),
                          onSubmitted: (_) => _handleLogin(),
                        ),
                      ),
                    ],
                  ),
                ),
                if (_error != null)
                  Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.sm),
                    child: Text(
                      _error!,
                      style: AppTypography.caption
                          .copyWith(color: AppColors.error),
                      textAlign: TextAlign.center,
                    ),
                  ),
                const SizedBox(height: AppSpacing.lg),
                PrimaryButton(
                  text: '登录',
                  loading: _loading,
                  onPressed: _handleLogin,
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  '登录即表示同意《服务条款》和《隐私政策》',
                  style: AppTypography.caption
                      .copyWith(color: AppColors.inkMuted48),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.xxl * 2),
              ],
            ),
          ),
        ),
      );
}
