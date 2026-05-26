// ==========================================
// Brew 咖啡 App - Flutter 实现
// 基于 Apple 设计语言的咖啡品牌应用
// 包含: 登录注册、商城、收藏、个人中心
// ==========================================

import 'package:flutter/material.dart';

// ==========================================
// 1. 设计系统 - 颜色
// ==========================================

class AppColors {
  static const primary = Color(0xFF6B4423);
  static const primaryDark = Color(0xFF4A2F19);
  static const primaryLight = Color(0xFF8B5E34);

  static const canvas = Color(0xFFFFFBF7);
  static const canvasParchment = Color(0xFFF5F1EB);
  static const surfaceDark1 = Color(0xFF2C2420);
  static const surfaceDark2 = Color(0xFF342A25);
  static const surfaceCard = Color(0xFFFFFFFF);

  static const ink = Color(0xFF2A2520);
  static const inkOnDark = Color(0xFFFFFBF7);
  static const inkMuted = Color(0xFF8A7D75);
  static const inkMuted48 = Color(0xFFB8ADA5);

  static const divider = Color(0xFFE8E1DB);
  static const hairline = Color(0xFFD4CCC4);

  static const error = Color(0xFFD32F2F);
  static const success = Color(0xFF2D5016);
}

// ==========================================
// 2. 设计系统 - 字体
// ==========================================

class AppTypography {
  static const heroDisplay = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.w600,
    height: 1.1,
    letterSpacing: -0.5,
  );
  static const displayLg = TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.w600,
    height: 1.15,
    letterSpacing: -0.3,
  );
  static const displayMd = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: -0.2,
  );
  static const lead = TextStyle(
    fontSize: 21,
    fontWeight: FontWeight.w400,
    height: 1.3,
    letterSpacing: 0.1,
  );
  static const tagline = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    height: 1.25,
    letterSpacing: -0.2,
  );
  static const body = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    height: 1.47,
    letterSpacing: -0.3,
  );
  static const bodyStrong = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    height: 1.47,
    letterSpacing: -0.3,
  );
  static const caption = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 1.38,
    letterSpacing: -0.1,
  );
  static const buttonLarge = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: 0,
  );
}

// ==========================================
// 3. 设计系统 - 间距 & 圆角
// ==========================================

class AppSpacing {
  static const xxs = 4.0;
  static const xs = 8.0;
  static const sm = 12.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
  static const xxl = 48.0;
  static const section = 64.0;
}

class AppRadius {
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 12.0;
  static const lg = 16.0;
  static const xl = 24.0;
  static const pill = 9999.0;
}

// ==========================================
// 4. 组件 - 主按钮
// ==========================================

class PrimaryButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final bool loading;

  const PrimaryButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.width,
    this.loading = false,
  }) : super(key: key);

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.loading ? null : (_) => setState(() => _scale = 0.95),
      onTapUp: widget.loading
          ? null
          : (_) {
              setState(() => _scale = 1.0);
              widget.onPressed?.call();
            },
      onTapCancel: () => setState(() => _scale = 1.0),
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
        child: Container(
          width: widget.width,
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(AppRadius.pill),
          ),
          child: Center(
            child: widget.loading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.canvas,
                    ),
                  )
                : Text(
                    widget.text,
                    style: AppTypography.buttonLarge.copyWith(
                      color: AppColors.canvas,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 5. 组件 - 次级按钮
// ==========================================

class SecondaryButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;

  const SecondaryButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.width,
  }) : super(key: key);

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.95),
      onTapUp: (_) {
        setState(() => _scale = 1.0);
        widget.onPressed?.call();
      },
      onTapCancel: () => setState(() => _scale = 1.0),
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
        child: Container(
          width: widget.width,
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: AppColors.primary, width: 1),
            borderRadius: BorderRadius.circular(AppRadius.pill),
          ),
          child: Center(
            child: Text(
              widget.text,
              style: AppTypography.buttonLarge.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 6. 组件 - 产品瓦片 (首页用)
// ==========================================

class ProductTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? imagePath;
  final Color backgroundColor;
  final bool isDark;
  final VoidCallback? onLearnMore;
  final VoidCallback? onBuy;

  const ProductTile({
    Key? key,
    required this.title,
    required this.subtitle,
    this.imagePath,
    this.backgroundColor = AppColors.canvas,
    this.isDark = false,
    this.onLearnMore,
    this.onBuy,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textColor = isDark ? AppColors.inkOnDark : AppColors.ink;
    final subtitleColor = isDark
        ? AppColors.inkOnDark.withOpacity(0.7)
        : AppColors.inkMuted;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.section,
        horizontal: AppSpacing.lg,
      ),
      color: backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: AppTypography.displayLg.copyWith(color: textColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: AppTypography.lead.copyWith(color: subtitleColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SecondaryButton(text: '了解更多', onPressed: onLearnMore),
              const SizedBox(width: 16),
              PrimaryButton(text: '立即购买', onPressed: onBuy),
            ],
          ),
          const SizedBox(height: 40),
          if (imagePath != null)
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x38000000),
                    blurRadius: 30,
                    offset: const Offset(0, 5),
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: Image.asset(imagePath!, height: 300, fit: BoxFit.contain),
            ),
        ],
      ),
    );
  }
}

// ==========================================
// 7. 组件 - 产品卡片 (商城用，支持收藏)
// ==========================================

class ProductCard extends StatelessWidget {
  final String name;
  final String price;
  final String? imagePath;
  final bool isFavorited;
  final VoidCallback? onTap;
  final VoidCallback? onToggleFavorite;

  const ProductCard({
    Key? key,
    required this.name,
    required this.price,
    this.imagePath,
    this.isFavorited = false,
    this.onTap,
    this.onToggleFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceCard,
          border: Border.all(color: AppColors.hairline, width: 1),
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 产品图
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: imagePath != null
                        ? Image.asset(imagePath!, fit: BoxFit.cover)
                        : Container(
                            color: AppColors.canvasParchment,
                            child: const Center(
                              child: Icon(
                                Icons.coffee,
                                size: 48,
                                color: AppColors.inkMuted48,
                              ),
                            ),
                          ),
                  ),
                ),
                // 收藏按钮
                Positioned(
                  top: 4,
                  right: 4,
                  child: GestureDetector(
                    onTap: onToggleFavorite,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceCard.withOpacity(0.9),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        isFavorited ? Icons.favorite : Icons.favorite_border,
                        size: 16,
                        color: isFavorited
                            ? AppColors.error
                            : AppColors.inkMuted,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              name,
              style: AppTypography.bodyStrong.copyWith(color: AppColors.ink),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              price,
              style: AppTypography.body.copyWith(color: AppColors.inkMuted),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 8. 认证状态管理
// ==========================================

class AuthState extends ChangeNotifier {
  bool _isLoggedIn = false;
  String _userName = '';
  String _userEmail = '';

  bool get isLoggedIn => _isLoggedIn;
  String get userName => _userName;
  String get userEmail => _userEmail;

  Future<bool> login(String email, String password) async {
    // 模拟网络请求延迟
    await Future.delayed(const Duration(milliseconds: 800));
    // 简单校验：邮箱非空且密码长度 >= 6
    if (email.trim().isNotEmpty && password.length >= 6) {
      _isLoggedIn = true;
      _userEmail = email.trim();
      _userName = email.trim().split('@').first;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> register(String name, String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 800));
    if (name.trim().isNotEmpty &&
        email.trim().isNotEmpty &&
        password.length >= 6) {
      _isLoggedIn = true;
      _userEmail = email.trim();
      _userName = name.trim();
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() {
    _isLoggedIn = false;
    _userName = '';
    _userEmail = '';
    notifyListeners();
  }
}

// ==========================================
// 9. 收藏状态管理
// ==========================================

class FavoritesState extends ChangeNotifier {
  final Set<String> _favorites = {};

  Set<String> get favorites => _favorites;
  int get count => _favorites.length;

  bool isFavorite(String productName) => _favorites.contains(productName);

  void toggle(String productName) {
    if (_favorites.contains(productName)) {
      _favorites.remove(productName);
    } else {
      _favorites.add(productName);
    }
    notifyListeners();
  }

  void remove(String productName) {
    _favorites.remove(productName);
    notifyListeners();
  }
}

// ==========================================
// 10. 页面 - 登录
// ==========================================

class LoginPage extends StatefulWidget {
  final AuthState authState;

  const LoginPage({Key? key, required this.authState}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  String? _errorText;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _errorText = null;
    });

    final success = await widget.authState.login(
      _emailController.text,
      _passwordController.text,
    );

    if (!mounted) return;
    setState(() {
      _loading = false;
    });
    if (!success) {
      setState(() {
        _errorText = '邮箱或密码不正确，请重试';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvas,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo 区域
                  const Icon(Icons.coffee, size: 64, color: AppColors.primary),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Brew',
                    style: AppTypography.displayLg.copyWith(
                      color: AppColors.ink,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    '享受每一杯的好时光',
                    style: AppTypography.body.copyWith(
                      color: AppColors.inkMuted,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.xxl),

                  // 邮箱
                  Text(
                    '邮箱',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.inkMuted,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    style: AppTypography.body,
                    decoration: _inputDecoration(
                      '请输入邮箱地址',
                      Icons.email_outlined,
                    ),
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? '请输入邮箱' : null,
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // 密码
                  Text(
                    '密码',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.inkMuted,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    textInputAction: TextInputAction.done,
                    style: AppTypography.body,
                    decoration: _inputDecoration('请输入密码', Icons.lock_outlined)
                        .copyWith(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              size: 20,
                            ),
                            onPressed: () => setState(
                              () => _obscurePassword = !_obscurePassword,
                            ),
                          ),
                        ),
                    validator: (v) =>
                        (v == null || v.length < 6) ? '密码至少需要6位' : null,
                    onFieldSubmitted: (_) => _handleLogin(),
                  ),
                  const SizedBox(height: AppSpacing.xs),

                  // 错误提示
                  if (_errorText != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: Text(
                        _errorText!,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.error,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                  const SizedBox(height: AppSpacing.lg),

                  // 登录按钮
                  PrimaryButton(
                    text: '登录',
                    loading: _loading,
                    onPressed: _handleLogin,
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // 去注册
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '还没有账号？',
                        style: AppTypography.body.copyWith(
                          color: AppColors.inkMuted,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  RegisterPage(authState: widget.authState),
                            ),
                          );
                        },
                        child: Text(
                          '立即注册',
                          style: AppTypography.bodyStrong.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: AppTypography.body.copyWith(color: AppColors.inkMuted48),
      prefixIcon: Icon(icon, size: 20, color: AppColors.inkMuted),
      filled: true,
      fillColor: AppColors.surfaceCard,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        borderSide: const BorderSide(color: AppColors.hairline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        borderSide: const BorderSide(color: AppColors.hairline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }
}

// ==========================================
// 11. 页面 - 注册
// ==========================================

class RegisterPage extends StatefulWidget {
  final AuthState authState;

  const RegisterPage({Key? key, required this.authState}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  String? _errorText;
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _errorText = null;
    });

    final success = await widget.authState.register(
      _nameController.text,
      _emailController.text,
      _passwordController.text,
    );

    if (!mounted) return;
    setState(() {
      _loading = false;
    });
    if (!success) {
      setState(() {
        _errorText = '注册失败，请检查填写信息';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvas,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.ink,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '创建账号',
                    style: AppTypography.displayMd.copyWith(
                      color: AppColors.ink,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    '加入 Brew，探索精品咖啡世界',
                    style: AppTypography.body.copyWith(
                      color: AppColors.inkMuted,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.xl),

                  // 昵称
                  Text(
                    '昵称',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.inkMuted,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  TextFormField(
                    controller: _nameController,
                    textInputAction: TextInputAction.next,
                    style: AppTypography.body,
                    decoration: _inputDecoration(
                      '请输入昵称',
                      Icons.person_outlined,
                    ),
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? '请输入昵称' : null,
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // 邮箱
                  Text(
                    '邮箱',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.inkMuted,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    style: AppTypography.body,
                    decoration: _inputDecoration(
                      '请输入邮箱地址',
                      Icons.email_outlined,
                    ),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return '请输入邮箱';
                      if (!v.contains('@')) return '请输入有效的邮箱地址';
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // 密码
                  Text(
                    '密码',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.inkMuted,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    textInputAction: TextInputAction.next,
                    style: AppTypography.body,
                    decoration:
                        _inputDecoration(
                          '请设置密码（至少6位）',
                          Icons.lock_outlined,
                        ).copyWith(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              size: 20,
                            ),
                            onPressed: () => setState(
                              () => _obscurePassword = !_obscurePassword,
                            ),
                          ),
                        ),
                    validator: (v) =>
                        (v == null || v.length < 6) ? '密码至少需要6位' : null,
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // 确认密码
                  Text(
                    '确认密码',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.inkMuted,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  TextFormField(
                    controller: _confirmController,
                    obscureText: _obscureConfirm,
                    textInputAction: TextInputAction.done,
                    style: AppTypography.body,
                    decoration: _inputDecoration('请再次输入密码', Icons.lock_outlined)
                        .copyWith(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureConfirm
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              size: 20,
                            ),
                            onPressed: () => setState(
                              () => _obscureConfirm = !_obscureConfirm,
                            ),
                          ),
                        ),
                    validator: (v) {
                      if (v == null || v.isEmpty) return '请确认密码';
                      if (v != _passwordController.text) return '两次输入的密码不一致';
                      return null;
                    },
                    onFieldSubmitted: (_) => _handleRegister(),
                  ),
                  const SizedBox(height: AppSpacing.xs),

                  // 错误提示
                  if (_errorText != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: Text(
                        _errorText!,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.error,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                  const SizedBox(height: AppSpacing.lg),

                  // 注册按钮
                  PrimaryButton(
                    text: '注册',
                    loading: _loading,
                    onPressed: _handleRegister,
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // 去登录
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '已有账号？',
                        style: AppTypography.body.copyWith(
                          color: AppColors.inkMuted,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Text(
                          '返回登录',
                          style: AppTypography.bodyStrong.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: AppTypography.body.copyWith(color: AppColors.inkMuted48),
      prefixIcon: Icon(icon, size: 20, color: AppColors.inkMuted),
      filled: true,
      fillColor: AppColors.surfaceCard,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        borderSide: const BorderSide(color: AppColors.hairline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        borderSide: const BorderSide(color: AppColors.hairline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }
}

// ==========================================
// 12. 页面 - 首页
// ==========================================

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvas,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceDark1,
        elevation: 0,
        toolbarHeight: 44,
        title: Text(
          'Brew',
          style: AppTypography.caption.copyWith(
            color: AppColors.inkOnDark,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProductTile(
              title: '手冲埃塞俄比亚',
              subtitle: '花香调 · 明亮果酸 · 柔顺口感',
              backgroundColor: AppColors.canvas,
              isDark: false,
              onLearnMore: () {},
              onBuy: () {},
            ),
            ProductTile(
              title: '冷萃哥伦比亚',
              subtitle: '巧克力风味 · 低酸度 · 醇厚顺滑',
              backgroundColor: AppColors.surfaceDark1,
              isDark: true,
              onLearnMore: () {},
              onBuy: () {},
            ),
            ProductTile(
              title: '单品意式拼配',
              subtitle: '坚果香 · 焦糖甜感 · 浓郁醇厚',
              backgroundColor: AppColors.canvasParchment,
              isDark: false,
              onLearnMore: () {},
              onBuy: () {},
            ),
            // 环保承诺
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: AppSpacing.section,
                horizontal: AppSpacing.xl,
              ),
              color: AppColors.canvasParchment,
              child: Column(
                children: [
                  const Icon(
                    Icons.eco_outlined,
                    size: 48,
                    color: Color(0xFF2D5016),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '2030 碳中和承诺',
                    style: AppTypography.displayMd.copyWith(
                      color: AppColors.ink,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '我们承诺在 2030 年实现全供应链碳中和,\n让每一杯咖啡都对地球更友好。',
                    style: AppTypography.body.copyWith(
                      color: AppColors.inkMuted,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  SecondaryButton(text: '了解更多', onPressed: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 13. 页面 - 商城（含收藏功能）
// ==========================================

class ShopPage extends StatefulWidget {
  final FavoritesState favoritesState;

  const ShopPage({Key? key, required this.favoritesState}) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  String _searchQuery = '';

  final List<Map<String, String>> _products = const [
    {'name': '肯尼亚 AA', 'price': '¥68'},
    {'name': '埃塞俄比亚 耶加雪菲', 'price': '¥78'},
    {'name': '哥伦比亚 蕙兰', 'price': '¥65'},
    {'name': '巴西 喜拉多', 'price': '¥55'},
    {'name': '危地马拉 安提瓜', 'price': '¥72'},
    {'name': '哥斯达黎加 塔拉珠', 'price': '¥85'},
    {'name': '云南 小粒咖啡', 'price': '¥48'},
    {'name': '印度尼西亚 曼特宁', 'price': '¥69'},
    {'name': '秘鲁 禅茶玛悠', 'price': '¥62'},
    {'name': '卢旺达 基伍湖', 'price': '¥75'},
  ];

  @override
  Widget build(BuildContext context) {
    final filteredProducts = _searchQuery.isEmpty
        ? _products
        : _products
              .where(
                (p) => p['name']!.toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ),
              )
              .toList();

    return Scaffold(
      backgroundColor: AppColors.canvas,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceDark1,
        elevation: 0,
        toolbarHeight: 44,
        title: Text(
          '商城',
          style: AppTypography.caption.copyWith(
            color: AppColors.inkOnDark,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 搜索框
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: AppColors.canvas,
                border: Border.all(color: AppColors.hairline, width: 1),
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, size: 18, color: AppColors.inkMuted),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      onChanged: (value) =>
                          setState(() => _searchQuery = value),
                      decoration: InputDecoration(
                        hintText: '搜索咖啡豆、器具...',
                        hintStyle: AppTypography.body.copyWith(
                          color: AppColors.inkMuted,
                        ),
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

          // 产品网格
          Expanded(
            child: filteredProducts.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.search_off,
                          size: 48,
                          color: AppColors.inkMuted48,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          '没有找到相关产品',
                          style: AppTypography.body.copyWith(
                            color: AppColors.inkMuted,
                          ),
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
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      final name = product['name']!;
                      return ProductCard(
                        name: name,
                        price: product['price']!,
                        isFavorited: widget.favoritesState.isFavorite(name),
                        onToggleFavorite: () =>
                            widget.favoritesState.toggle(name),
                        onTap: () {},
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 14. 页面 - 收藏
// ==========================================

class FavoritesPage extends StatelessWidget {
  final FavoritesState favoritesState;

  const FavoritesPage({Key? key, required this.favoritesState})
    : super(key: key);

  // 完整产品数据（用于在收藏页显示价格）
  static const _allProducts = <Map<String, String>>[
    {'name': '肯尼亚 AA', 'price': '¥68'},
    {'name': '埃塞俄比亚 耶加雪菲', 'price': '¥78'},
    {'name': '哥伦比亚 蕙兰', 'price': '¥65'},
    {'name': '巴西 喜拉多', 'price': '¥55'},
    {'name': '危地马拉 安提瓜', 'price': '¥72'},
    {'name': '哥斯达黎加 塔拉珠', 'price': '¥85'},
    {'name': '云南 小粒咖啡', 'price': '¥48'},
    {'name': '印度尼西亚 曼特宁', 'price': '¥69'},
    {'name': '秘鲁 禅茶玛悠', 'price': '¥62'},
    {'name': '卢旺达 基伍湖', 'price': '¥75'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvas,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceDark1,
        elevation: 0,
        toolbarHeight: 44,
        title: Text(
          '收藏',
          style: AppTypography.caption.copyWith(
            color: AppColors.inkOnDark,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: ListenableBuilder(
        listenable: favoritesState,
        builder: (context, _) {
          final favList = favoritesState.favorites.toList();

          if (favList.isEmpty) {
            return _buildEmptyState();
          }

          // 查找对应产品信息
          final favProducts = favList.map((name) {
            final match = _allProducts.where((p) => p['name'] == name);
            return match.isNotEmpty
                ? match.first
                : {'name': name, 'price': '¥--'};
          }).toList();

          return _buildFavoritesGrid(context, favProducts);
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.canvasParchment,
              borderRadius: BorderRadius.circular(AppRadius.xl),
            ),
            child: const Icon(
              Icons.favorite_border,
              size: 36,
              color: AppColors.inkMuted48,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            '暂无收藏',
            style: AppTypography.tagline.copyWith(color: AppColors.ink),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '去商城逛逛，把喜欢的咖啡加入收藏吧',
            style: AppTypography.body.copyWith(color: AppColors.inkMuted),
          ),
          const SizedBox(height: AppSpacing.lg),
          SecondaryButton(
            text: '去逛逛',
            onPressed: () {
              // 通过导航切换到商城 tab
              final nav = context
                  .findAncestorStateOfType<_MainNavigationState>();
              nav?.switchToTab(1);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritesGrid(
    BuildContext context,
    List<Map<String, String>> products,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 顶部统计
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            AppSpacing.md,
            AppSpacing.md,
            0,
          ),
          child: Text(
            '共 ${products.length} 件收藏',
            style: AppTypography.caption.copyWith(color: AppColors.inkMuted),
          ),
        ),
        // 收藏列表
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(AppSpacing.md),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.72,
              crossAxisSpacing: AppSpacing.md,
              mainAxisSpacing: AppSpacing.md,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              final name = product['name']!;
              return ProductCard(
                name: name,
                price: product['price']!,
                isFavorited: true,
                onToggleFavorite: () => favoritesState.remove(name),
                onTap: () {},
              );
            },
          ),
        ),
      ],
    );
  }
}

// ==========================================
// 15. 页面 - 我的（个人中心）
// ==========================================

class ProfilePage extends StatelessWidget {
  final AuthState authState;
  final FavoritesState favoritesState;

  const ProfilePage({
    Key? key,
    required this.authState,
    required this.favoritesState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvas,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceDark1,
        elevation: 0,
        toolbarHeight: 44,
        title: Text(
          '我的',
          style: AppTypography.caption.copyWith(
            color: AppColors.inkOnDark,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 用户信息卡片
            _buildUserCard(),
            const SizedBox(height: AppSpacing.lg),

            // 统计信息
            _buildStatsRow(),
            const SizedBox(height: AppSpacing.lg),

            // 菜单列表
            _buildMenuSection(context),
            const SizedBox(height: AppSpacing.lg),

            // 退出登录
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: SizedBox(
                width: double.infinity,
                child: SecondaryButton(
                  text: '退出登录',
                  onPressed: () => _showLogoutDialog(context),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }

  Widget _buildUserCard() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.md,
        0,
      ),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark1,
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Row(
        children: [
          // 头像
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(AppRadius.xl),
            ),
            child: Center(
              child: Text(
                authState.userName.isNotEmpty
                    ? authState.userName[0].toUpperCase()
                    : '?',
                style: AppTypography.displayMd.copyWith(
                  color: AppColors.canvas,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  authState.userName,
                  style: AppTypography.tagline.copyWith(
                    color: AppColors.inkOnDark,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  authState.userEmail,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.inkOnDark.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.inkOnDark, size: 20),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return ListenableBuilder(
      listenable: favoritesState,
      builder: (context, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Row(
            children: [
              _buildStatItem(
                '收藏',
                '${favoritesState.count}',
                Icons.favorite_outlined,
              ),
              const SizedBox(width: AppSpacing.sm),
              _buildStatItem('订单', '0', Icons.receipt_long_outlined),
              const SizedBox(width: AppSpacing.sm),
              _buildStatItem('优惠券', '3', Icons.card_giftcard_outlined),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Expanded(
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
              style: AppTypography.tagline.copyWith(color: AppColors.ink),
            ),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              label,
              style: AppTypography.caption.copyWith(color: AppColors.inkMuted),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuSection(BuildContext context) {
    final menuItems = [
      {
        'icon': Icons.shopping_bag_outlined,
        'title': '我的订单',
        'subtitle': '查看全部订单',
      },
      {
        'icon': Icons.location_on_outlined,
        'title': '收货地址',
        'subtitle': '管理配送地址',
      },
      {
        'icon': Icons.card_giftcard_outlined,
        'title': '优惠券',
        'subtitle': '3 张可用',
      },
      {
        'icon': Icons.notifications_outlined,
        'title': '消息通知',
        'subtitle': '订单与促销消息',
      },
      {'icon': Icons.settings_outlined, 'title': '设置', 'subtitle': '账号与偏好设置'},
      {'icon': Icons.help_outline, 'title': '帮助与反馈', 'subtitle': '常见问题与客服'},
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: AppColors.hairline),
      ),
      child: Column(
        children: menuItems.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isLast = index == menuItems.length - 1;

          return Column(
            children: [
              ListTile(
                leading: Icon(
                  item['icon'] as IconData,
                  color: AppColors.primary,
                  size: 22,
                ),
                title: Text(
                  item['title'] as String,
                  style: AppTypography.bodyStrong.copyWith(
                    color: AppColors.ink,
                  ),
                ),
                subtitle: Text(
                  item['subtitle'] as String,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.inkMuted,
                  ),
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                  color: AppColors.inkMuted48,
                  size: 20,
                ),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${item['title']}功能开发中'),
                      backgroundColor: AppColors.surfaceDark1,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                    ),
                  );
                },
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                ),
              ),
              if (!isLast)
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

  void _showLogoutDialog(BuildContext context) {
    showDialog(
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
          '退出登录后需要重新登录才能使用',
          style: AppTypography.body.copyWith(color: AppColors.inkMuted),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              '取消',
              style: AppTypography.bodyStrong.copyWith(
                color: AppColors.inkMuted,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              authState.logout();
            },
            child: Text(
              '退出',
              style: AppTypography.bodyStrong.copyWith(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 16. 主导航
// ==========================================

class MainNavigation extends StatefulWidget {
  final AuthState authState;
  final FavoritesState favoritesState;

  const MainNavigation({
    Key? key,
    required this.authState,
    required this.favoritesState,
  }) : super(key: key);

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  void switchToTab(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      const HomePage(),
      ShopPage(favoritesState: widget.favoritesState),
      FavoritesPage(favoritesState: widget.favoritesState),
      ProfilePage(
        authState: widget.authState,
        favoritesState: widget.favoritesState,
      ),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        backgroundColor: AppColors.canvas,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.inkMuted,
        selectedLabelStyle: AppTypography.caption,
        unselectedLabelStyle: AppTypography.caption,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.coffee_outlined),
            activeIcon: Icon(Icons.coffee),
            label: '商城',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            activeIcon: Icon(Icons.favorite),
            label: '收藏',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            activeIcon: Icon(Icons.person),
            label: '我的',
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 17. 主应用入口
// ==========================================

void main() {
  runApp(const BrewApp());
}

class BrewApp extends StatefulWidget {
  const BrewApp({Key? key}) : super(key: key);

  @override
  State<BrewApp> createState() => _BrewAppState();
}

class _BrewAppState extends State<BrewApp> {
  final AuthState _authState = AuthState();
  final FavoritesState _favoritesState = FavoritesState();

  @override
  void dispose() {
    _authState.dispose();
    _favoritesState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brew',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.canvas,
        fontFamily: null,
        dialogTheme: DialogThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.xl),
          ),
        ),
      ),
      home: ListenableBuilder(
        listenable: _authState,
        builder: (context, _) {
          if (!_authState.isLoggedIn) {
            return LoginPage(authState: _authState);
          }
          return MainNavigation(
            authState: _authState,
            favoritesState: _favoritesState,
          );
        },
      ),
    );
  }
}
