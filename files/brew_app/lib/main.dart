// ==========================================
// Brew 咖啡 App - Flutter 实现
// 手机号登录 · 本地数据 + 图片读取
// 管理后台: http://localhost:3000/admin (Web)
// ==========================================

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';

// ==========================================
// 1. 本地数据路径
// ==========================================

class LocalData {
  static String _root() => Platform.environment['BREW_DATA_ROOT'] ?? Directory.current.path;
  static String dataPath(String file) => '${_root()}/data/$file';
  static String uploadPath(String file) => '${_root()}/uploads/$file';

  static Future<Map<String, dynamic>?> readJson(String filename) async {
    try {
      final f = File(dataPath(filename));
      if (!await f.exists()) return null;
      return json.decode(await f.readAsString());
    } catch (_) { return null; }
  }

  static Future<Uint8List?> readImage(String filename) async {
    if (filename.isEmpty) return null;
    try {
      final f = File(uploadPath(filename));
      if (!await f.exists()) return null;
      return await f.readAsBytes();
    } catch (_) { return null; }
  }
}

// ==========================================
// 2. 设计系统
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

class AppTypography {
  static const heroDisplay = TextStyle(fontSize: 48, fontWeight: FontWeight.w600, height: 1.1, letterSpacing: -0.5);
  static const displayLg = TextStyle(fontSize: 34, fontWeight: FontWeight.w600, height: 1.15, letterSpacing: -0.3);
  static const displayMd = TextStyle(fontSize: 28, fontWeight: FontWeight.w600, height: 1.2, letterSpacing: -0.2);
  static const tagline = TextStyle(fontSize: 17, fontWeight: FontWeight.w600, height: 1.25, letterSpacing: -0.2);
  static const body = TextStyle(fontSize: 17, fontWeight: FontWeight.w400, height: 1.47, letterSpacing: -0.3);
  static const bodyStrong = TextStyle(fontSize: 17, fontWeight: FontWeight.w600, height: 1.47, letterSpacing: -0.3);
  static const caption = TextStyle(fontSize: 13, fontWeight: FontWeight.w400, height: 1.38, letterSpacing: -0.1);
  static const buttonLarge = TextStyle(fontSize: 17, fontWeight: FontWeight.w600, height: 1.2, letterSpacing: 0);
}

class AppSpacing {
  static const xxs = 4.0; static const xs = 8.0; static const sm = 12.0;
  static const md = 16.0; static const lg = 24.0; static const xl = 32.0; static const xxl = 48.0;
}

class AppRadius {
  static const xs = 4.0; static const sm = 8.0; static const md = 12.0;
  static const lg = 16.0; static const xl = 24.0; static const pill = 9999.0;
}

// ==========================================
// 3. 默认数据
// ==========================================

class DefaultData {
  static const defaultGradient1 = [Color(0xFF6B4423), Color(0xFF3E2515)];
  static const defaultGradient2 = [Color(0xFF2C2420), Color(0xFF1A1410)];
  static const defaultGradient3 = [Color(0xFF5D4037), Color(0xFF3E2723)];

  static const banners = [
    {'id': '1', 'title': '手冲埃塞俄比亚', 'subtitle': '花香调 · 明亮果酸 · 柔顺口感', 'tag': '新品上市', 'image': '', 'gradient': defaultGradient1},
    {'id': '2', 'title': '冷萃哥伦比亚', 'subtitle': '巧克力风味 · 低酸度 · 醇厚顺滑', 'tag': '热卖推荐', 'image': '', 'gradient': defaultGradient2},
    {'id': '3', 'title': '单品意式拼配', 'subtitle': '坚果香 · 焦糖甜感 · 浓郁醇厚', 'tag': '限定特供', 'image': '', 'gradient': defaultGradient3},
  ];

  static const coffeeCards = [
    {'id': '1', 'name': '肯尼亚 AA', 'desc': '明亮的黑醋栗与柑橘风味，层次分明，余韵悠长', 'origin': '非洲 · 肯尼亚', 'roast': '浅烘', 'image': ''},
    {'id': '2', 'name': '埃塞俄比亚 耶加雪菲', 'desc': '茉莉花香与柠檬酸质，如花茶般清爽细腻', 'origin': '非洲 · 埃塞俄比亚', 'roast': '浅烘', 'image': ''},
    {'id': '3', 'name': '哥伦比亚 蕙兰', 'desc': '焦糖甜感与坚果香气，醇厚平衡的经典之选', 'origin': '南美 · 哥伦比亚', 'roast': '中烘', 'image': ''},
    {'id': '4', 'name': '云南 小粒咖啡', 'desc': '国货精品，红糖甜香与淡淡果韵，柔和不失个性', 'origin': '亚洲 · 中国云南', 'roast': '中深烘', 'image': ''},
    {'id': '5', 'name': '印尼 曼特宁', 'desc': '草本醇香与黑巧克力尾韵，口感厚重顺滑', 'origin': '亚洲 · 苏门答腊', 'roast': '深烘', 'image': ''},
    {'id': '6', 'name': '哥斯达黎加 塔拉珠', 'desc': '蜂蜜甜感与热带水果风味，干净明亮的回甘', 'origin': '中美 · 哥斯达黎加', 'roast': '中烘', 'image': ''},
  ];

  static const products = [
    {'id': '1', 'name': '肯尼亚 AA', 'price': '¥68', 'category': '非洲', 'origin': '肯尼亚', 'roast': '浅烘', 'image': '', 'desc': '明亮的黑醋栗与柑橘风味'},
    {'id': '2', 'name': '埃塞俄比亚 耶加雪菲', 'price': '¥78', 'category': '非洲', 'origin': '埃塞俄比亚', 'roast': '浅烘', 'image': '', 'desc': '茉莉花香与柠檬酸质'},
    {'id': '3', 'name': '哥伦比亚 蕙兰', 'price': '¥65', 'category': '南美', 'origin': '哥伦比亚', 'roast': '中烘', 'image': '', 'desc': '焦糖甜感与坚果香气'},
    {'id': '4', 'name': '巴西 喜拉多', 'price': '¥55', 'category': '南美', 'origin': '巴西', 'roast': '中烘', 'image': '', 'desc': '柔和顺滑，经典风味'},
    {'id': '5', 'name': '危地马拉 安提瓜', 'price': '¥72', 'category': '中美', 'origin': '危地马拉', 'roast': '中深烘', 'image': '', 'desc': '浓郁巧克力风味'},
    {'id': '6', 'name': '哥斯达黎加 塔拉珠', 'price': '¥85', 'category': '中美', 'origin': '哥斯达黎加', 'roast': '中烘', 'image': '', 'desc': '蜂蜜甜感与热带水果'},
    {'id': '7', 'name': '云南 小粒咖啡', 'price': '¥48', 'category': '亚洲', 'origin': '中国云南', 'roast': '中深烘', 'image': '', 'desc': '国货精品，红糖甜香'},
    {'id': '8', 'name': '印度尼西亚 曼特宁', 'price': '¥69', 'category': '亚洲', 'origin': '苏门答腊', 'roast': '深烘', 'image': '', 'desc': '草本醇香与黑巧克力'},
    {'id': '9', 'name': '秘鲁 禅茶玛悠', 'price': '¥62', 'category': '南美', 'origin': '秘鲁', 'roast': '中烘', 'image': '', 'desc': '干净明亮的酸甜平衡'},
    {'id': '10', 'name': '卢旺达 基伍湖', 'price': '¥75', 'category': '非洲', 'origin': '卢旺达', 'roast': '浅烘', 'image': '', 'desc': '莓果风味，层次丰富'},
  ];
}

// ==========================================
// 4. 数据仓库 — 本地文件覆盖
// ==========================================

class DataRepository extends ChangeNotifier {
  List<Map<String, dynamic>> _products = List<Map<String, dynamic>>.from(DefaultData.products);
  List<Map<String, dynamic>> _banners = List<Map<String, dynamic>>.from(DefaultData.banners);
  List<Map<String, dynamic>> _coffeeCards = List<Map<String, dynamic>>.from(DefaultData.coffeeCards);

  List<Map<String, dynamic>> get products => _products;
  List<Map<String, dynamic>> get banners => _banners;
  List<Map<String, dynamic>> get coffeeCards => _coffeeCards;

  static List<Map<String, dynamic>> merge(List<Map<String, dynamic>> defaults, dynamic overrideData) {
    if (overrideData == null) return List<Map<String, dynamic>>.from(defaults);
    final list = (overrideData is List) ? overrideData : [];
    if (list.isEmpty) return List<Map<String, dynamic>>.from(defaults);
    final result = <Map<String, dynamic>>[];
    final omap = <String, Map<String, dynamic>>{};
    for (final item in list) { if (item is Map<String, dynamic> && item['id'] != null) omap[item['id'].toString()] = item; }
    for (final def in defaults) {
      final id = def['id'].toString();
      if (omap.containsKey(id)) {
        final merged = Map<String, dynamic>.from(def);
        omap[id]!.forEach((k, v) { merged[k] = v; });
        result.add(merged);
      } else { result.add(Map<String, dynamic>.from(def)); }
    }
    for (final e in omap.entries) { if (!defaults.any((d) => d['id'].toString() == e.key)) result.add(e.value); }
    return result;
  }

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

// ==========================================
// 5. 图片组件
// ==========================================

class AppImage extends StatelessWidget {
  final String? filename; final double? width, height; final BoxFit fit;
  final double borderRadius; final Color? placeholderColor; final Widget? fallback;
  const AppImage({Key? key, this.filename, this.width, this.height, this.fit = BoxFit.cover, this.borderRadius = 0, this.placeholderColor, this.fallback}) : super(key: key);

  @override Widget build(BuildContext c) => ClipRRect(borderRadius: BorderRadius.circular(borderRadius), child: _ImageLoader(filename: filename, width: width, height: height, fit: fit, placeholderColor: placeholderColor ?? AppColors.canvasParchment, fallback: fallback ?? const Icon(Icons.coffee, size: 48, color: AppColors.inkMuted48)));
}

class _ImageLoader extends StatefulWidget {
  final String? filename; final double? width, height; final BoxFit fit;
  final Color placeholderColor; final Widget fallback;
  const _ImageLoader({required this.filename, this.width, this.height, required this.fit, required this.placeholderColor, required this.fallback});
  @override State<_ImageLoader> createState() => _ImageLoaderState();
}

class _ImageLoaderState extends State<_ImageLoader> {
  Uint8List? _bytes; bool _loading = true;
  @override void initState() { super.initState(); _load(); }
  @override void didUpdateWidget(_ImageLoader o) { if (o.filename != widget.filename) { _bytes = null; _loading = true; _load(); } }

  Future<void> _load() async {
    final fn = widget.filename;
    if (fn == null || fn.isEmpty) { if (mounted) setState(() => _loading = false); return; }
    final bytes = await LocalData.readImage(fn);
    if (mounted) setState(() { _bytes = bytes; _loading = false; });
  }

  @override Widget build(BuildContext c) {
    if (_loading) return Container(color: widget.placeholderColor, width: widget.width, height: widget.height, child: const Center(child: CircularProgressIndicator(strokeWidth: 2)));
    if (_bytes != null) return Image.memory(_bytes!, width: widget.width, height: widget.height, fit: widget.fit);
    return Container(color: widget.placeholderColor, width: widget.width, height: widget.height, child: Center(child: widget.fallback));
  }
}

// ==========================================
// 6. 按钮组件
// ==========================================

class PrimaryButton extends StatefulWidget {
  final String text; final VoidCallback? onPressed; final double? width; final bool loading;
  const PrimaryButton({Key? key, required this.text, this.onPressed, this.width, this.loading = false}) : super(key: key);
  @override State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  double _scale = 1.0;
  @override Widget build(BuildContext c) => GestureDetector(
    onTapDown: widget.loading ? null : (_) => setState(() => _scale = 0.95),
    onTapUp: widget.loading ? null : (_) { setState(() => _scale = 1.0); widget.onPressed?.call(); },
    onTapCancel: () => setState(() => _scale = 1.0),
    child: AnimatedScale(scale: _scale, duration: const Duration(milliseconds: 100), curve: Curves.easeOut,
      child: Container(width: widget.width, height: 48, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(AppRadius.pill)),
        child: Center(child: widget.loading ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.canvas))
          : Text(widget.text, style: AppTypography.buttonLarge.copyWith(color: AppColors.canvas))),
      ),
    ),
  );
}

// ==========================================
// 7. 产品卡片
// ==========================================

class ProductCard extends StatelessWidget {
  final String name; final String price; final String? imageFile; final bool isFavorited;
  final VoidCallback? onTap, onToggleFavorite;
  const ProductCard({Key? key, required this.name, required this.price, this.imageFile, this.isFavorited = false, this.onTap, this.onToggleFavorite}) : super(key: key);

  @override Widget build(BuildContext c) => Material(color: AppColors.surfaceCard, borderRadius: BorderRadius.circular(AppRadius.lg),
    child: InkWell(borderRadius: BorderRadius.circular(AppRadius.lg), onTap: onTap,
      splashColor: AppColors.primary.withOpacity(0.1), highlightColor: AppColors.primary.withOpacity(0.05),
      child: Ink(decoration: BoxDecoration(border: Border.all(color: AppColors.hairline), borderRadius: BorderRadius.circular(AppRadius.lg)),
        padding: const EdgeInsets.all(AppSpacing.md), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(children: [
            ClipRRect(borderRadius: BorderRadius.circular(AppRadius.sm), child: AspectRatio(aspectRatio: 1, child: AppImage(filename: imageFile))),
            Positioned(top: 4, right: 4, child: _FavBtn(isFavorited: isFavorited, onTap: onToggleFavorite)),
          ]),
          const SizedBox(height: 12),
          Text(name, style: AppTypography.bodyStrong.copyWith(color: AppColors.ink), maxLines: 2, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 4),
          Text(price, style: AppTypography.body.copyWith(color: AppColors.inkMuted)),
        ]),
      ),
    ),
  );
}

class _FavBtn extends StatefulWidget {
  final bool isFavorited; final VoidCallback? onTap;
  const _FavBtn({required this.isFavorited, this.onTap});
  @override State<_FavBtn> createState() => _FavBtnState();
}

class _FavBtnState extends State<_FavBtn> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);
  late Animation<double> _anim = Tween<double>(begin: 1.0, end: 1.35).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutBack));
  @override void dispose() { _ctrl.dispose(); super.dispose(); }
  void _tap() { _ctrl.forward().then((_) => _ctrl.reverse()); widget.onTap?.call(); }
  @override Widget build(BuildContext c) => GestureDetector(onTap: _tap,
    child: ScaleTransition(scale: _anim,
      child: Container(width: 32, height: 32, decoration: BoxDecoration(color: AppColors.surfaceCard.withOpacity(0.9), shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4, offset: const Offset(0, 2))]),
        child: Icon(widget.isFavorited ? Icons.favorite : Icons.favorite_border, size: 16, color: widget.isFavorited ? AppColors.error : AppColors.inkMuted)),
    ),
  );
}

// ==========================================
// 8. 认证 & 收藏
// ==========================================

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

  void logout() { _isLoggedIn = false; _phoneNumber = ''; notifyListeners(); }
}

class FavoritesState extends ChangeNotifier {
  final Set<String> _favs = {};
  Set<String> get favorites => _favs; int get count => _favs.length;
  bool isFavorite(String n) => _favs.contains(n);
  void toggle(String n) { _favs.contains(n) ? _favs.remove(n) : _favs.add(n); notifyListeners(); }
  void remove(String n) { _favs.remove(n); notifyListeners(); }
}

// ==========================================
// 9. 手机号登录页
// ==========================================

class LoginPage extends StatefulWidget {
  final AuthState authState;
  const LoginPage({Key? key, required this.authState}) : super(key: key);
  @override State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _phoneCtrl = TextEditingController();
  bool _loading = false;
  String? _error;

  @override void dispose() { _phoneCtrl.dispose(); super.dispose(); }

  bool _isValidPhone(String v) => v.trim().length == 11 && RegExp(r'^1\d{10}$').hasMatch(v.trim());

  void _handleLogin() {
    final phone = _phoneCtrl.text.trim();
    if (!_isValidPhone(phone)) {
      setState(() => _error = '请输入正确的11位手机号码');
      return;
    }
    setState(() { _loading = true; _error = null; });
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      widget.authState.login(phone);
    });
  }

  @override Widget build(BuildContext c) => Scaffold(backgroundColor: AppColors.canvas, body: SafeArea(child: SingleChildScrollView(padding: const EdgeInsets.all(AppSpacing.xl), child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
    const SizedBox(height: AppSpacing.xxl * 2),
    const Icon(Icons.coffee, size: 64, color: AppColors.primary),
    const SizedBox(height: AppSpacing.md),
    Text('Brew', style: AppTypography.displayLg.copyWith(color: AppColors.ink), textAlign: TextAlign.center),
    const SizedBox(height: AppSpacing.xs),
    Text('享受每一杯的好时光', style: AppTypography.body.copyWith(color: AppColors.inkMuted), textAlign: TextAlign.center),
    const SizedBox(height: AppSpacing.xxl),
    Text('手机号码', style: AppTypography.caption.copyWith(color: AppColors.inkMuted)),
    const SizedBox(height: AppSpacing.xs),
    Container(decoration: BoxDecoration(color: AppColors.surfaceCard, border: Border.all(color: AppColors.hairline), borderRadius: BorderRadius.circular(AppRadius.md)),
      child: Row(children: [
        const Padding(padding: EdgeInsets.only(left: 16), child: Icon(Icons.phone_android, size: 20, color: AppColors.inkMuted)),
        Expanded(child: TextField(
          controller: _phoneCtrl,
          keyboardType: TextInputType.phone,
          maxLength: 11,
          style: AppTypography.body,
          decoration: const InputDecoration(counterText: '', hintText: '请输入手机号码', hintStyle: TextStyle(fontSize: 17, color: AppColors.inkMuted48), border: InputBorder.none, contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14)),
          onSubmitted: (_) => _handleLogin(),
        )),
      ]),
    ),
    if (_error != null)
      Padding(padding: const EdgeInsets.only(top: AppSpacing.sm), child: Text(_error!, style: AppTypography.caption.copyWith(color: AppColors.error), textAlign: TextAlign.center)),
    const SizedBox(height: AppSpacing.lg),
    PrimaryButton(text: '登录', loading: _loading, onPressed: _handleLogin),
    const SizedBox(height: AppSpacing.md),
    Text('登录即表示同意《服务条款》和《隐私政策》', style: AppTypography.caption.copyWith(color: AppColors.inkMuted48), textAlign: TextAlign.center),
    const SizedBox(height: AppSpacing.xxl * 2),
  ]))));
}

// ==========================================
// 10. 首页
// ==========================================

class HomePage extends StatefulWidget {
  final DataRepository dataRepo;
  const HomePage({Key? key, required this.dataRepo}) : super(key: key);
  @override State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageCtrl = PageController(); int _current = 0; late final Timer _timer;
  @override void initState() { super.initState(); _timer = Timer.periodic(const Duration(seconds: 4), (t) { final b = widget.dataRepo.banners; if (b.isNotEmpty && _pageCtrl.hasClients) _pageCtrl.animateToPage((_current + 1) % b.length, duration: const Duration(milliseconds: 600), curve: Curves.easeInOut); }); }
  @override void dispose() { _timer.cancel(); _pageCtrl.dispose(); super.dispose(); }

  Color _parseColor(String hex) { try { return Color(int.parse('FF${hex.replaceFirst('#', '')}', radix: 16)); } catch (_) { return AppColors.primary; } }

  @override Widget build(BuildContext c) => ListenableBuilder(listenable: widget.dataRepo, builder: (_, __) {
    final banners = widget.dataRepo.banners, cards = widget.dataRepo.coffeeCards;
    return Scaffold(backgroundColor: AppColors.canvas, body: CustomScrollView(slivers: [
      SliverAppBar(backgroundColor: AppColors.surfaceDark1, pinned: true, elevation: 0, toolbarHeight: 44, centerTitle: true, title: Text('Brew', style: AppTypography.caption.copyWith(color: AppColors.inkOnDark, fontSize: 15, fontWeight: FontWeight.w600))),
      SliverToBoxAdapter(child: _carousel(banners)),
      SliverToBoxAdapter(child: _sectionHeader()),
      if (cards.isEmpty) const SliverToBoxAdapter(child: Padding(padding: EdgeInsets.all(AppSpacing.xxl), child: Center(child: Text('暂无咖啡数据', style: TextStyle(color: AppColors.inkMuted)))))
      else SliverPadding(padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md), sliver: SliverGrid(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.68, crossAxisSpacing: AppSpacing.sm, mainAxisSpacing: AppSpacing.sm), delegate: SliverChildBuilderDelegate((ctx, i) => _card(cards[i]), childCount: cards.length))),
      SliverToBoxAdapter(child: Container(margin: const EdgeInsets.all(AppSpacing.md), padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm), decoration: BoxDecoration(color: const Color(0xFF2D5016).withOpacity(0.06), borderRadius: BorderRadius.circular(AppRadius.md)), child: const Row(children: [Icon(Icons.eco_outlined, size: 18, color: Color(0xFF2D5016)), SizedBox(width: AppSpacing.xs), Expanded(child: Text('2030 碳中和承诺 · 让每杯咖啡都对地球更友好', style: TextStyle(fontSize: 13, color: Color(0xFF2D5016)))), Icon(Icons.chevron_right, size: 16, color: Color(0xFF2D5016))]))),
      const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.md)),
    ]));
  });

  Widget _carousel(List<Map<String, dynamic>> list) {
    if (list.isEmpty) return const SizedBox(height: 300, child: Center(child: Text('暂无轮播')));
    return Column(children: [
      SizedBox(height: 300, child: PageView.builder(controller: _pageCtrl, itemCount: list.length, onPageChanged: (i) => setState(() => _current = i), itemBuilder: (ctx, i) {
        final b = list[i]; final img = b['image'] as String? ?? '';
        final grads = (b['gradient'] is List ? (b['gradient'] as List).map((c) => _parseColor(c.toString())).toList() : <Color>[AppColors.primary, AppColors.primaryDark]);
        return Padding(padding: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.sm, AppSpacing.md, AppSpacing.xs), child: Material(color: Colors.transparent, child: InkWell(borderRadius: BorderRadius.circular(AppRadius.xl), onTap: () {}, child: Ink(decoration: BoxDecoration(borderRadius: BorderRadius.circular(AppRadius.xl), boxShadow: [BoxShadow(color: grads.last.withOpacity(0.4), blurRadius: 20, offset: const Offset(0, 8))]), child: Stack(fit: StackFit.expand, children: [
          ClipRRect(borderRadius: BorderRadius.circular(AppRadius.xl), child: img.isNotEmpty ? ColorFiltered(colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.35), BlendMode.darken), child: AppImage(filename: img, fit: BoxFit.cover)) : Container(decoration: BoxDecoration(gradient: LinearGradient(colors: grads, begin: Alignment.topLeft, end: Alignment.bottomRight)))),
          Padding(padding: const EdgeInsets.all(AppSpacing.xl), child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.end, children: [
            Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(AppRadius.pill)), child: Text(b['tag'] as String? ?? '', style: AppTypography.caption.copyWith(color: AppColors.inkOnDark, fontWeight: FontWeight.w600))),
            const SizedBox(height: AppSpacing.md),
            Text(b['title'] as String? ?? '', style: AppTypography.displayLg.copyWith(color: AppColors.inkOnDark)),
            const SizedBox(height: AppSpacing.xs),
            Text(b['subtitle'] as String? ?? '', style: AppTypography.body.copyWith(color: AppColors.inkOnDark.withOpacity(0.75))),
            const SizedBox(height: AppSpacing.md),
            const Row(children: [Text('立即探索', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: AppColors.inkOnDark)), SizedBox(width: 4), Icon(Icons.arrow_forward, color: AppColors.inkOnDark, size: 18)]),
          ])),
        ])))));
      })),
      const SizedBox(height: AppSpacing.sm),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(list.length, (i) => AnimatedContainer(duration: const Duration(milliseconds: 300), margin: const EdgeInsets.symmetric(horizontal: 4), width: i == _current ? 24 : 8, height: 8, decoration: BoxDecoration(color: i == _current ? AppColors.primary : AppColors.hairline, borderRadius: BorderRadius.circular(AppRadius.pill))))),
    ]);
  }

  Widget _sectionHeader() => Padding(padding: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.xl, AppSpacing.md, AppSpacing.sm), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    Text('探索产地风味', style: AppTypography.tagline.copyWith(color: AppColors.ink)),
    GestureDetector(onTap: () => context.findAncestorStateOfType<MainNavigationState>()?.switchToTab(1), child: const Row(children: [Text('查看全部', style: TextStyle(fontSize: 13, color: AppColors.primary)), SizedBox(width: 2), Icon(Icons.chevron_right, color: AppColors.primary, size: 16)])),
  ]));

  Widget _card(Map<String, dynamic> c) => Material(color: Colors.transparent, child: InkWell(borderRadius: BorderRadius.circular(AppRadius.xl), onTap: () {}, child: Ink(decoration: BoxDecoration(color: AppColors.surfaceCard, borderRadius: BorderRadius.circular(AppRadius.xl), border: Border.all(color: AppColors.hairline)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Expanded(flex: 5, child: ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.xl)), child: Stack(fit: StackFit.expand, children: [
      AppImage(filename: c['image'] as String?, borderRadius: 0),
      Positioned(left: 12, top: 10, child: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: Colors.black.withOpacity(0.3), borderRadius: BorderRadius.circular(AppRadius.pill)), child: Text(c['roast'] as String? ?? '', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)))),
    ]))),
    Expanded(flex: 4, child: Padding(padding: const EdgeInsets.all(AppSpacing.sm), child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(c['name'] as String? ?? '', style: AppTypography.caption.copyWith(fontWeight: FontWeight.w600, color: AppColors.ink, height: 1.3), maxLines: 2, overflow: TextOverflow.ellipsis),
      const SizedBox(height: 4),
      Expanded(child: Text(c['desc'] as String? ?? '', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: AppColors.inkMuted, height: 1.4), maxLines: 3, overflow: TextOverflow.ellipsis)),
      const SizedBox(height: 4),
      Row(children: [const Icon(Icons.location_on_outlined, size: 12, color: AppColors.inkMuted48), const SizedBox(width: 2), Expanded(child: Text(c['origin'] as String? ?? '', style: const TextStyle(fontSize: 10, color: AppColors.inkMuted48), maxLines: 1, overflow: TextOverflow.ellipsis))]),
    ]))),
  ]))));
}

// ==========================================
// 11. 商城
// ==========================================

class ShopPage extends StatefulWidget {
  final FavoritesState fav; final DataRepository dataRepo;
  const ShopPage({Key? key, required this.fav, required this.dataRepo}) : super(key: key);
  @override State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  String _q = ''; String _cat = '全部';
  static const _cats = ['全部', '非洲', '南美', '亚洲', '中美'];
  List<Map<String, dynamic>> get _filtered {
    var l = widget.dataRepo.products;
    if (_cat != '全部') l = l.where((p) => p['category'] == _cat).toList();
    if (_q.isNotEmpty) l = l.where((p) => (p['name'] ?? '').toString().toLowerCase().contains(_q.toLowerCase())).toList();
    return l;
  }

  @override Widget build(BuildContext c) => ListenableBuilder(listenable: widget.dataRepo, builder: (_, __) {
    final filtered = _filtered;
    return Scaffold(backgroundColor: AppColors.canvas, appBar: AppBar(backgroundColor: AppColors.surfaceDark1, elevation: 0, toolbarHeight: 44, centerTitle: true, title: Text('商城', style: AppTypography.caption.copyWith(color: AppColors.inkOnDark, fontSize: 15, fontWeight: FontWeight.w600))), body: Column(children: [
      Padding(padding: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.md, AppSpacing.md, AppSpacing.sm), child: Container(height: 44, padding: const EdgeInsets.symmetric(horizontal: 20), decoration: BoxDecoration(color: AppColors.canvas, border: Border.all(color: AppColors.hairline), borderRadius: BorderRadius.circular(AppRadius.pill)), child: Row(children: [const Icon(Icons.search, size: 18, color: AppColors.inkMuted), const SizedBox(width: 8), Expanded(child: TextField(onChanged: (v) => setState(() => _q = v), decoration: InputDecoration(hintText: '搜索咖啡豆...', hintStyle: AppTypography.body.copyWith(color: AppColors.inkMuted), border: InputBorder.none, contentPadding: EdgeInsets.zero, isDense: true), style: AppTypography.body))]))),
      SizedBox(height: 40, child: ListView.separated(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md), itemCount: _cats.length, separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.xs), itemBuilder: (ctx, i) { final s = _cats[i] == _cat; return GestureDetector(onTap: () => setState(() => _cat = _cats[i]), child: AnimatedContainer(duration: const Duration(milliseconds: 200), padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: s ? AppColors.primary : AppColors.surfaceCard, borderRadius: BorderRadius.circular(AppRadius.pill), border: Border.all(color: s ? AppColors.primary : AppColors.hairline)), child: Text(_cats[i], style: AppTypography.caption.copyWith(color: s ? AppColors.canvas : AppColors.inkMuted, fontWeight: FontWeight.w600)))); })),
      const SizedBox(height: AppSpacing.sm),
      Padding(padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md), child: Row(children: [Text('共 ${filtered.length} 款产品', style: AppTypography.caption.copyWith(color: AppColors.inkMuted))])),
      const SizedBox(height: AppSpacing.xs),
      Expanded(child: filtered.isEmpty ? Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.search_off, size: 48, color: AppColors.inkMuted48), const SizedBox(height: AppSpacing.md), Text('没有找到相关产品', style: AppTypography.body.copyWith(color: AppColors.inkMuted))])) : GridView.builder(padding: const EdgeInsets.all(AppSpacing.md), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.72, crossAxisSpacing: AppSpacing.md, mainAxisSpacing: AppSpacing.md), itemCount: filtered.length, itemBuilder: (ctx, i) { final p = filtered[i]; final n = p['name'] as String? ?? ''; return ProductCard(name: n, price: p['price'] as String? ?? '', imageFile: p['image'] as String?, isFavorited: widget.fav.isFavorite(n), onToggleFavorite: () => widget.fav.toggle(n)); }])),
    ]));
  });
}

// ==========================================
// 12. 个人中心
// ==========================================

class ProfilePage extends StatelessWidget {
  final AuthState auth; final FavoritesState fav; final DataRepository dataRepo;
  const ProfilePage({Key? key, required this.auth, required this.fav, required this.dataRepo}) : super(key: key);

  @override Widget build(BuildContext c) => Scaffold(backgroundColor: AppColors.canvas, appBar: AppBar(backgroundColor: AppColors.surfaceDark1, elevation: 0, toolbarHeight: 44, centerTitle: true, title: Text('我的', style: AppTypography.caption.copyWith(color: AppColors.inkOnDark, fontSize: 15, fontWeight: FontWeight.w600))), body: SingleChildScrollView(child: Column(children: [
    _userCard(), const SizedBox(height: AppSpacing.lg), _stats(), const SizedBox(height: AppSpacing.lg),
    _favSection(c), const SizedBox(height: AppSpacing.lg), _menu(c), const SizedBox(height: AppSpacing.lg),
    Padding(padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md), child: SizedBox(width: double.infinity, child: SecondaryButton(text: '退出登录', onPressed: () => _logout(c)))),
    const SizedBox(height: AppSpacing.xxl),
  ])));

  Widget _userCard() => Container(width: double.infinity, margin: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.md, AppSpacing.md, 0), padding: const EdgeInsets.all(AppSpacing.lg), decoration: BoxDecoration(color: AppColors.surfaceDark1, borderRadius: BorderRadius.circular(AppRadius.xl)), child: Row(children: [
    Container(width: 64, height: 64, decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(AppRadius.xl)), child: Center(child: Icon(Icons.phone_android, size: 28, color: AppColors.canvas))),
    const SizedBox(width: AppSpacing.md),
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(auth.phoneNumber, style: AppTypography.tagline.copyWith(color: AppColors.inkOnDark)),
      const SizedBox(height: AppSpacing.xxs),
      const Text('已通过手机号登录', style: AppTypography.caption.copyWith(color: AppColors.inkOnDark48)),
    ])),
    const Icon(Icons.chevron_right, color: AppColors.inkOnDark, size: 20),
  ]));

  Widget _stats() => ListenableBuilder(listenable: fav, builder: (_, __) => Padding(padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md), child: Row(children: [
    _statItem('收藏', '${fav.count}', Icons.favorite_outlined), const SizedBox(width: AppSpacing.sm),
    _statItem('订单', '0', Icons.receipt_long_outlined), const SizedBox(width: AppSpacing.sm),
    _statItem('优惠券', '3', Icons.card_giftcard_outlined),
  ])));

  Widget _statItem(String l, String v, IconData i) => Expanded(child: Container(padding: const EdgeInsets.symmetric(vertical: AppSpacing.md), decoration: BoxDecoration(color: AppColors.surfaceCard, borderRadius: BorderRadius.circular(AppRadius.lg), border: Border.all(color: AppColors.hairline)), child: Column(children: [Icon(i, size: 22, color: AppColors.primary), const SizedBox(height: AppSpacing.xs), Text(v, style: AppTypography.tagline.copyWith(color: AppColors.ink)), const SizedBox(height: AppSpacing.xxs), Text(l, style: AppTypography.caption.copyWith(color: AppColors.inkMuted))])));

  Widget _favSection(BuildContext context) => ListenableBuilder(listenable: fav, builder: (_, __) {
    final fl = fav.favorites.toList();
    return Container(margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md), decoration: BoxDecoration(color: AppColors.surfaceCard, borderRadius: BorderRadius.circular(AppRadius.xl), border: Border.all(color: AppColors.hairline)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(padding: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.md, AppSpacing.md, 0), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Row(children: [const Icon(Icons.favorite, size: 18, color: AppColors.error), const SizedBox(width: AppSpacing.xs), Text('我的收藏', style: AppTypography.bodyStrong.copyWith(color: AppColors.ink))]), Text('${fav.count} 件', style: AppTypography.caption.copyWith(color: AppColors.inkMuted))])),
      if (fl.isEmpty) Padding(padding: const EdgeInsets.all(AppSpacing.xl), child: Center(child: Column(children: [const Icon(Icons.favorite_border, size: 36, color: AppColors.inkMuted48), const SizedBox(height: AppSpacing.sm), Text('还没有收藏咖啡', style: AppTypography.caption.copyWith(color: AppColors.inkMuted)), const SizedBox(height: AppSpacing.xs), GestureDetector(onTap: () => context.findAncestorStateOfType<MainNavigationState>()?.switchToTab(1), child: Text('去商城逛逛', style: AppTypography.caption.copyWith(color: AppColors.primary, fontWeight: FontWeight.w600)))])))
      else SizedBox(height: 180, child: ListView.separated(scrollDirection: Axis.horizontal, padding: const EdgeInsets.all(AppSpacing.md), itemCount: fl.length, separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm), itemBuilder: (ctx, i) {
        final n = fl[i]; final m = dataRepo.products.where((p) => p['name'] == n); final info = m.isNotEmpty ? m.first : <String, dynamic>{'name': n, 'price': '¥--', 'image': ''};
        return SizedBox(width: 140, child: Material(color: AppColors.canvasParchment, borderRadius: BorderRadius.circular(AppRadius.md), child: InkWell(borderRadius: BorderRadius.circular(AppRadius.md), onTap: () {}, child: Padding(padding: const EdgeInsets.all(AppSpacing.xs), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ClipRRect(borderRadius: BorderRadius.circular(AppRadius.sm), child: AspectRatio(aspectRatio: 1, child: AppImage(filename: info['image'] as String?))),
          const SizedBox(height: AppSpacing.xs),
          Text(info['name'] as String? ?? '', style: AppTypography.caption.copyWith(fontWeight: FontWeight.w600, color: AppColors.ink), maxLines: 1, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 2),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(info['price'] as String? ?? '', style: const TextStyle(fontSize: 12, color: AppColors.inkMuted)), GestureDetector(onTap: () => fav.remove(n), child: const Icon(Icons.close, size: 14, color: AppColors.inkMuted48))]),
        ])))));
      })),
    ]));
  });

  Widget _menu(BuildContext context) {
    final items = [{'icon': Icons.shopping_bag_outlined, 'title': '我的订单', 'sub': '查看全部订单'},{'icon': Icons.location_on_outlined, 'title': '收货地址', 'sub': '管理配送地址'},{'icon': Icons.card_giftcard_outlined, 'title': '优惠券', 'sub': '3 张可用'},{'icon': Icons.notifications_outlined, 'title': '消息通知', 'sub': '订单与促销消息'},{'icon': Icons.settings_outlined, 'title': '设置', 'sub': '账号与偏好设置'},{'icon': Icons.help_outline, 'title': '帮助与反馈', 'sub': '常见问题与客服'}];
    return Container(margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md), decoration: BoxDecoration(color: AppColors.surfaceCard, borderRadius: BorderRadius.circular(AppRadius.xl), border: Border.all(color: AppColors.hairline)), child: Column(children: items.asMap().entries.map((e) { final it = e.value; final last = e.key == items.length - 1; return Column(children: [ListTile(leading: Icon(it['icon'] as IconData, color: AppColors.primary, size: 22), title: Text(it['title'] as String, style: AppTypography.bodyStrong.copyWith(color: AppColors.ink)), subtitle: Text(it['sub'] as String, style: AppTypography.caption.copyWith(color: AppColors.inkMuted)), trailing: const Icon(Icons.chevron_right, color: AppColors.inkMuted48, size: 20), onTap: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${it['title']}功能开发中'), backgroundColor: AppColors.surfaceDark1, behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.sm)))), contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md)), if (!last) const Divider(color: AppColors.divider, height: 1, indent: AppSpacing.lg + AppSpacing.md + 22, endIndent: AppSpacing.md)]); }).toList()));
  }

  Widget SecondaryButton({required String text, VoidCallback? onPressed, double? width}) => _SecondaryButton(text: text, onPressed: onPressed, width: width);

  void _logout(BuildContext c) => showDialog(context: c, builder: (ctx) => AlertDialog(backgroundColor: AppColors.surfaceCard, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.xl)), title: Text('确认退出', style: AppTypography.tagline.copyWith(color: AppColors.ink)), content: Text('退出后需重新登录', style: AppTypography.body.copyWith(color: AppColors.inkMuted)), actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: Text('取消', style: AppTypography.bodyStrong.copyWith(color: AppColors.inkMuted))), TextButton(onPressed: () { Navigator.pop(ctx); auth.logout(); }, child: Text('退出', style: AppTypography.bodyStrong.copyWith(color: AppColors.error)))]));
}

// 次级按钮（独立组件，移出 ProfilePage 以避免嵌套）
class _SecondaryButton extends StatefulWidget {
  final String text; final VoidCallback? onPressed; final double? width;
  const _SecondaryButton({Key? key, required this.text, this.onPressed, this.width}) : super(key: key);
  @override State<_SecondaryButton> createState() => _SecondaryButtonState();
}
class _SecondaryButtonState extends State<_SecondaryButton> {
  double _scale = 1.0;
  @override Widget build(BuildContext c) => GestureDetector(
    onTapDown: (_) => setState(() => _scale = 0.95),
    onTapUp: (_) { setState(() => _scale = 1.0); widget.onPressed?.call(); },
    onTapCancel: () => setState(() => _scale = 1.0),
    child: AnimatedScale(scale: _scale, duration: const Duration(milliseconds: 100), curve: Curves.easeOut,
      child: Container(width: widget.width, height: 48, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(color: Colors.transparent, border: Border.all(color: AppColors.primary, width: 1), borderRadius: BorderRadius.circular(AppRadius.pill)),
        child: Center(child: Text(widget.text, style: AppTypography.buttonLarge.copyWith(color: AppColors.primary))),
      ),
    ),
  );
}

// ==========================================
// 13. 主导航
// ==========================================

class MainNavigation extends StatefulWidget {
  final AuthState auth; final FavoritesState fav; final DataRepository repo;
  const MainNavigation({Key? key, required this.auth, required this.fav, required this.repo}) : super(key: key);
  @override State<MainNavigation> createState() => MainNavigationState();
}

class MainNavigationState extends State<MainNavigation> {
  int _idx = 0;
  @override void initState() { super.initState(); widget.repo.loadFromDisk(); }
  void switchToTab(int i) => setState(() => _idx = i);

  @override Widget build(BuildContext c) {
    final pages = [HomePage(dataRepo: widget.repo), ShopPage(fav: widget.fav, dataRepo: widget.repo), ProfilePage(auth: widget.auth, fav: widget.fav, dataRepo: widget.repo)];
    return Scaffold(body: pages[_idx], bottomNavigationBar: ListenableBuilder(listenable: widget.fav, builder: (_, __) {
      final n = widget.fav.count;
      return BottomNavigationBar(currentIndex: _idx, onTap: (i) => setState(() => _idx = i), backgroundColor: AppColors.canvas, selectedItemColor: AppColors.primary, unselectedItemColor: AppColors.inkMuted, selectedLabelStyle: AppTypography.caption, unselectedLabelStyle: AppTypography.caption, type: BottomNavigationBarType.fixed, elevation: 0, items: [
        const BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: '首页'),
        const BottomNavigationBarItem(icon: Icon(Icons.coffee_outlined), activeIcon: Icon(Icons.coffee), label: '商城'),
        BottomNavigationBarItem(icon: n == 0 ? const Icon(Icons.person_outlined) : _badge(Icons.person_outlined, n), activeIcon: n == 0 ? const Icon(Icons.person) : _badge(Icons.person, n), label: '我的'),
      ]);
    }));
  }

  Widget _badge(IconData i, int n) => Stack(clipBehavior: Clip.none, children: [Icon(i), Positioned(right: -8, top: -4, child: Container(padding: const EdgeInsets.all(3), decoration: const BoxDecoration(color: AppColors.error, shape: BoxShape.circle), constraints: const BoxConstraints(minWidth: 16, minHeight: 16), child: Text('$n', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700), textAlign: TextAlign.center)))]);
}

// ==========================================
// 14. 入口
// ==========================================

void main() => runApp(const BrewApp());

class BrewApp extends StatefulWidget {
  const BrewApp({Key? key}) : super(key: key);
  @override State<BrewApp> createState() => _BrewAppState();
}

class _BrewAppState extends State<BrewApp> {
  final _auth = AuthState(); final _fav = FavoritesState(); final _repo = DataRepository();
  @override void dispose() { _auth.dispose(); _fav.dispose(); _repo.dispose(); super.dispose(); }
  @override Widget build(BuildContext c) => MaterialApp(title: 'Brew', debugShowCheckedModeBanner: false, theme: ThemeData(primaryColor: AppColors.primary, scaffoldBackgroundColor: AppColors.canvas), home: ListenableBuilder(listenable: _auth, builder: (_, __) => _auth.isLoggedIn ? MainNavigation(auth: _auth, fav: _fav, repo: _repo) : LoginPage(authState: _auth)));
}
