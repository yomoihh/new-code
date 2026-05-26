// ==========================================
// Brew 咖啡 App - Flutter 实现示例
// 基于 Apple 设计语言的咖啡品牌应用
// ==========================================

import 'package:flutter/material.dart';

// ==========================================
// 1. 设计系统 - 颜色
// ==========================================

class AppColors {
  // 主色调
  static const primary = Color(0xFF6B4423);
  static const primaryDark = Color(0xFF4A2F19);
  static const primaryLight = Color(0xFF8B5E34);

  // 表面色
  static const canvas = Color(0xFFFFFBF7);
  static const canvasParchment = Color(0xFFF5F1EB);
  static const surfaceDark1 = Color(0xFF2C2420);
  static const surfaceDark2 = Color(0xFF342A25);
  static const surfaceCard = Color(0xFFFFFFFF);

  // 文字
  static const ink = Color(0xFF2A2520);
  static const inkOnDark = Color(0xFFFFFBF7);
  static const inkMuted = Color(0xFF8A7D75);
  static const inkMuted48 = Color(0xFFB8ADA5);

  // 边框
  static const divider = Color(0xFFE8E1DB);
  static const hairline = Color(0xFFD4CCC4);
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
// 3. 设计系统 - 间距
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

// ==========================================
// 4. 设计系统 - 圆角
// ==========================================

class AppRadius {
  static const none = 0.0;
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 12.0;
  static const lg = 16.0;
  static const xl = 24.0;
  static const pill = 9999.0;
}

// ==========================================
// 5. 组件 - 主按钮
// ==========================================

class PrimaryButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;

  const PrimaryButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.width,
  }) : super(key: key);

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
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
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(AppRadius.pill),
          ),
          child: Center(
            child: Text(
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
// 6. 组件 - 次级按钮
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
// 7. 组件 - 产品瓦片
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
    // 提高深色背景下的副标题对比度
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
          // 产品名称
          Text(
            title,
            style: AppTypography.displayLg.copyWith(color: textColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),

          // 副标题
          Text(
            subtitle,
            style: AppTypography.lead.copyWith(color: subtitleColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),

          // CTA 按钮组
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SecondaryButton(text: '了解更多', onPressed: onLearnMore),
              const SizedBox(width: 16),
              PrimaryButton(text: '立即购买', onPressed: onBuy),
            ],
          ),
          const SizedBox(height: 40),

          // 产品图片(带阴影)
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
// 8. 组件 - 产品卡片
// ==========================================

class ProductCard extends StatelessWidget {
  final String name;
  final String price;
  final String? imagePath;
  final VoidCallback? onTap;

  const ProductCard({
    Key? key,
    required this.name,
    required this.price,
    this.imagePath,
    this.onTap,
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
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 产品图 (1:1)
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.sm),
              child: AspectRatio(
                aspectRatio: 1,
                child: imagePath != null
                    ? Image.asset(imagePath!, fit: BoxFit.cover)
                    : Container(color: AppColors.canvasParchment),
              ),
            ),
            const SizedBox(height: 12),

            // 产品名
            Text(
              name,
              style: AppTypography.bodyStrong.copyWith(color: AppColors.ink),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),

            // 价格
            Text(
              price,
              style: AppTypography.body.copyWith(color: AppColors.inkMuted),
            ),
            const SizedBox(height: 8),

            // 购买链接
            Text(
              '购买',
              style: AppTypography.caption.copyWith(color: AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 9. 页面 - 首页
// ==========================================

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvas,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceDark1, // 使用设计系统颜色
        elevation: 0,
        toolbarHeight: 44,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: AppColors.inkOnDark, size: 20),
          onPressed: () {},
        ),
        title: Text(
          'Brew',
          style: AppTypography.caption.copyWith(
            color: AppColors.inkOnDark,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.shopping_bag_outlined,
              color: AppColors.inkOnDark,
              size: 20,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 产品瓦片 1 - 浅色
            ProductTile(
              title: '手冲埃塞俄比亚',
              subtitle: '花香调 · 明亮果酸 · 柔顺口感',
              backgroundColor: AppColors.canvas,
              isDark: false,
              onLearnMore: () {},
              onBuy: () {},
            ),

            // 产品瓦片 2 - 深色
            ProductTile(
              title: '冷萃哥伦比亚',
              subtitle: '巧克力风味 · 低酸度 · 醇厚顺滑',
              backgroundColor: AppColors.surfaceDark1,
              isDark: true,
              onLearnMore: () {},
              onBuy: () {},
            ),

            // 产品瓦片 3 - 驼色
            ProductTile(
              title: '单品意式拼配',
              subtitle: '坚果香 · 焦糖甜感 · 浓郁醇厚',
              backgroundColor: AppColors.canvasParchment,
              isDark: false,
              onLearnMore: () {},
              onBuy: () {},
            ),

            // 环保承诺区块
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
// 10. 页面 - 商城
// ==========================================

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  String _searchQuery = '';

  // 示例产品数据
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
    // 根据搜索过滤产品
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
        backgroundColor: AppColors.surfaceDark1, // 使用设计系统颜色
        elevation: 0,
        toolbarHeight: 44,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: AppColors.inkOnDark, size: 20),
          onPressed: () {},
        ),
        title: Text(
          '商城',
          style: AppTypography.caption.copyWith(
            color: AppColors.inkOnDark,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.shopping_bag_outlined,
              color: AppColors.inkOnDark,
              size: 20,
            ),
            onPressed: () {},
          ),
        ],
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
                border: Border.all(
                  color: AppColors.hairline, // 使用设计系统颜色
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, size: 18, color: AppColors.inkMuted),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
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
            child: GridView.builder(
              padding: const EdgeInsets.all(AppSpacing.md),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: AppSpacing.md,
                mainAxisSpacing: AppSpacing.md,
              ),
              itemCount: filteredProducts.length, // 动态数量
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return ProductCard(
                  name: product['name']!,
                  price: product['price']!,
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
// 11. 主应用入口
// ==========================================

void main() {
  runApp(const BrewApp());
}

class BrewApp extends StatelessWidget {
  const BrewApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brew',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.canvas,
        // fontFamily 已移除，让系统自动适配
      ),
      home: const MainNavigation(),
    );
  }
}

// ==========================================
// 12. 主导航
// ==========================================

class MainNavigation extends StatefulWidget {
  const MainNavigation({Key? key}) : super(key: key);

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    ShopPage(),
    Center(child: Text('收藏', style: AppTypography.displayMd)),
    Center(child: Text('我的', style: AppTypography.displayMd)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        backgroundColor: AppColors.canvas,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.inkMuted,
        selectedLabelStyle: AppTypography.caption,
        unselectedLabelStyle: AppTypography.caption,
        type: BottomNavigationBarType.fixed,
        surfaceTintColor: Colors.transparent, // 替代已弃用的 elevation
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
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: '我的',
          ),
        ],
      ),
    );
  }
}
