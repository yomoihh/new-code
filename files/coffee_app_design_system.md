# Brew - 咖啡品牌 App 设计系统

## 设计理念

受 Apple 设计语言启发，Brew 采用**摄影优先、极简克制**的设计方式。每一屏都是一张咖啡的肖像——豆子的质感、拉花的细节、咖啡师的手艺——UI 退居幕后,让产品自己说话。

### 核心原则
- **呼吸感**: 大量留白,每个元素都有足够的空间
- **单一强调色**: 咖啡棕作为唯一的交互色
- **摄影为王**: 高质量咖啡摄影占据主视觉
- **克制的动效**: 微妙但精准的过渡动画

---

## 色彩系统 (Colors)

### 品牌色与强调色
```dart
// 主色调 - 深烘焙咖啡棕
static const primary = Color(0xFF6B4423);          // 所有可点击元素
static const primaryDark = Color(0xFF4A2F19);      // 按压状态
static const primaryLight = Color(0xFF8B5E34);     // 浅色背景上的链接

// 表面色
static const canvas = Color(0xFFFFFBF7);           // 温暖的奶白色主画布
static const canvasParchment = Color(0xFFF5F1EB);  // 浅驼色次级背景
static const surfaceDark1 = Color(0xFF2C2420);     // 深色瓦片 1
static const surfaceDark2 = Color(0xFF342A25);     // 深色瓦片 2
static const surfaceCard = Color(0xFFFFFFFF);      // 卡片白色

// 文字
static const ink = Color(0xFF2A2520);              // 主文本
static const inkOnDark = Color(0xFFFFFBF7);        // 深色背景文字
static const inkMuted = Color(0xFF8A7D75);         // 次级文本
static const inkMuted48 = Color(0xFFB8ADA5);       // 禁用/说明文字

// 边框与分割线
static const divider = Color(0xFFE8E1DB);
static const hairline = Color(0xFFD4CCC4);
```

### 语义色
```dart
// 成功/新鲜
static const success = Color(0xFF2D5016);

// 警告/热饮
static const warning = Color(0xFFD97706);

// 错误
static const error = Color(0xFFC5503A);
```

---

## 字体排版 (Typography)

使用系统字体栈以保证 Apple 设备上的最佳体验:
- **中文**: PingFang SC (苹果默认)
- **英文**: SF Pro Display / SF Pro Text
- **数字**: 表格数字 (Tabular)

### 字阶体系

```dart
// 超大标题 - 首页主打产品
static const heroDisplay = TextStyle(
  fontSize: 48,
  fontWeight: FontWeight.w600,
  height: 1.1,
  letterSpacing: -0.5,
);

// 大标题 - 产品瓦片
static const displayLg = TextStyle(
  fontSize: 34,
  fontWeight: FontWeight.w600,
  height: 1.15,
  letterSpacing: -0.3,
);

// 中标题 - 分区标题
static const displayMd = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.w600,
  height: 1.2,
  letterSpacing: -0.2,
);

// 引导文字 - 副标题
static const lead = TextStyle(
  fontSize: 21,
  fontWeight: FontWeight.w400,
  height: 1.3,
  letterSpacing: 0.1,
);

// 标签 - 小标题
static const tagline = TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.w600,
  height: 1.25,
  letterSpacing: -0.2,
);

// 正文 - 主要正文
static const body = TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.w400,
  height: 1.47,
  letterSpacing: -0.3,
);

// 正文加粗
static const bodyStrong = TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.w600,
  height: 1.47,
  letterSpacing: -0.3,
);

// 说明文字
static const caption = TextStyle(
  fontSize: 13,
  fontWeight: FontWeight.w400,
  height: 1.38,
  letterSpacing: -0.1,
);

// 按钮文字
static const buttonLarge = TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.w600,
  height: 1.2,
  letterSpacing: 0,
);

// 小按钮文字
static const buttonSmall = TextStyle(
  fontSize: 13,
  fontWeight: FontWeight.w600,
  height: 1.2,
  letterSpacing: -0.1,
);
```

---

## 间距系统 (Spacing)

基于 8px 网格系统:

```dart
static const xxs = 4.0;
static const xs = 8.0;
static const sm = 12.0;
static const md = 16.0;
static const lg = 24.0;
static const xl = 32.0;
static const xxl = 48.0;
static const section = 64.0;  // 大区块垂直间距
```

---

## 圆角系统 (Border Radius)

```dart
static const none = 0.0;
static const xs = 4.0;
static const sm = 8.0;
static const md = 12.0;
static const lg = 16.0;
static const xl = 24.0;
static const pill = 9999.0;  // 胶囊形状
```

---

## 阴影系统 (Shadows)

遵循 Apple 原则:**仅对产品图片使用阴影**

```dart
// 产品图片阴影 - 唯一的阴影
static const productShadow = [
  BoxShadow(
    color: Color(0x38000000),  // rgba(0, 0, 0, 0.22)
    blurRadius: 30,
    offset: Offset(0, 5),
    spreadRadius: 3,
  ),
];

// 卡片无阴影,使用边框区分
static const cardBorder = Border(
  top: BorderSide(color: Color(0xFFE8E1DB), width: 1),
  bottom: BorderSide(color: Color(0xFFE8E1DB), width: 1),
  left: BorderSide(color: Color(0xFFE8E1DB), width: 1),
  right: BorderSide(color: Color(0xFFE8E1DB), width: 1),
);
```

---

## 组件规范

### 1. 主按钮 (Primary Button)

**视觉**: 胶囊形状,咖啡棕背景

```dart
Container(
  height: 48,
  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  decoration: BoxDecoration(
    color: AppColors.primary,
    borderRadius: BorderRadius.circular(AppRadius.pill),
  ),
  child: Text(
    '立即购买',
    style: AppTypography.buttonLarge.copyWith(
      color: AppColors.canvas,
    ),
  ),
)
```

**交互**: 点击时缩放至 0.95

```dart
onTap: () {
  // 缩放动画
  _controller.forward().then((_) => _controller.reverse());
}
```

### 2. 次级按钮 (Secondary Button)

**视觉**: 胶囊形状,透明背景,咖啡棕描边

```dart
Container(
  height: 48,
  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  decoration: BoxDecoration(
    color: Colors.transparent,
    border: Border.all(color: AppColors.primary, width: 1),
    borderRadius: BorderRadius.circular(AppRadius.pill),
  ),
  child: Text(
    '了解更多',
    style: AppTypography.buttonLarge.copyWith(
      color: AppColors.primary,
    ),
  ),
)
```

### 3. 产品瓦片 (Product Tile)

**布局**: 全屏宽度,垂直居中内容

```dart
Container(
  width: double.infinity,
  padding: EdgeInsets.symmetric(vertical: AppSpacing.section),
  color: AppColors.canvas,
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      // 产品名称
      Text(
        '手冲埃塞俄比亚',
        style: AppTypography.displayLg.copyWith(
          color: AppColors.ink,
        ),
        textAlign: TextAlign.center,
      ),
      SizedBox(height: 8),
      
      // 副标题
      Text(
        '花香调 · 明亮果酸 · 柔顺口感',
        style: AppTypography.lead.copyWith(
          color: AppColors.inkMuted,
        ),
        textAlign: TextAlign.center,
      ),
      SizedBox(height: 24),
      
      // CTA 按钮组
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PrimaryButton(text: '了解更多'),
          SizedBox(width: 16),
          SecondaryButton(text: '立即购买'),
        ],
      ),
      SizedBox(height: 40),
      
      // 产品图片 (带阴影)
      Container(
        decoration: BoxDecoration(
          boxShadow: AppShadows.productShadow,
        ),
        child: Image.asset(
          'assets/coffee_product.png',
          height: 400,
        ),
      ),
    ],
  ),
)
```

### 4. 产品卡片 (Product Card)

**用于网格展示**

```dart
Container(
  decoration: BoxDecoration(
    color: AppColors.surfaceCard,
    border: AppShadows.cardBorder,
    borderRadius: BorderRadius.circular(AppRadius.lg),
  ),
  padding: EdgeInsets.all(AppSpacing.lg),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // 产品图 (1:1)
      ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        child: Image.asset(
          'assets/coffee_card.png',
          width: double.infinity,
          aspectRatio: 1,
          fit: BoxFit.cover,
        ),
      ),
      SizedBox(height: 12),
      
      // 产品名
      Text(
        '肯尼亚 AA',
        style: AppTypography.bodyStrong.copyWith(
          color: AppColors.ink,
        ),
      ),
      SizedBox(height: 4),
      
      // 价格
      Text(
        '¥68',
        style: AppTypography.body.copyWith(
          color: AppColors.inkMuted,
        ),
      ),
      SizedBox(height: 8),
      
      // 购买链接
      GestureDetector(
        onTap: () {},
        child: Text(
          '购买',
          style: AppTypography.caption.copyWith(
            color: AppColors.primary,
          ),
        ),
      ),
    ],
  ),
)
```

### 5. 顶部导航栏 (App Bar)

**超薄黑色导航栏**

```dart
AppBar(
  backgroundColor: Color(0xFF000000),
  elevation: 0,
  toolbarHeight: 44,
  leading: IconButton(
    icon: Icon(Icons.menu, color: AppColors.inkOnDark, size: 20),
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
      icon: Icon(Icons.shopping_bag_outlined, 
                 color: AppColors.inkOnDark, size: 20),
      onPressed: () {},
    ),
  ],
)
```

### 6. 底部导航栏 (Bottom Navigation)

```dart
BottomNavigationBar(
  backgroundColor: AppColors.canvas,
  selectedItemColor: AppColors.primary,
  unselectedItemColor: AppColors.inkMuted,
  selectedLabelStyle: AppTypography.caption,
  unselectedLabelStyle: AppTypography.caption,
  type: BottomNavigationBarType.fixed,
  items: [
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
)
```

---

## 页面布局示例

### 首页 (Home)

**结构**: 全屏产品瓦片堆叠,明暗交替

```
[顶部导航栏 - 黑色]
[产品瓦片 1 - 浅色背景]
[产品瓦片 2 - 深色背景]
[产品瓦片 3 - 浅色背景]
[环保承诺区块 - 驼色背景]
[页脚]
```

### 商城页 (Shop)

**结构**: 搜索 + 产品网格

```
[顶部导航栏]
[搜索框 - 胶囊形状]
[分类筛选 - 横向滚动胶囊]
[产品网格 - 2列,带卡片]
```

### 产品详情页 (Product Detail)

**结构**: 沉浸式大图 + 滚动内容

```
[返回按钮 - 浮动于图片上]
[产品大图 - 全屏可滑动]
[产品信息区]
  - 产品名称 (displayLg)
  - 价格 (displayMd)
  - 描述段落 (body)
  - 规格选择器 (胶囊 chips)
[底部悬浮栏]
  - 价格
  - 加入购物车按钮
```

---

## 动画原则

### 微交互

1. **按钮点击**: `scale(0.95)` + 100ms 弹性缓动
2. **页面切换**: 右滑进入,300ms 缓动
3. **卡片展开**: 从卡片位置放大到全屏,400ms
4. **加载**: 简单的 fade in,无转圈动画

### 代码示例

```dart
// 按钮缩放动画
GestureDetector(
  onTapDown: (_) {
    setState(() => _scale = 0.95);
  },
  onTapUp: (_) {
    setState(() => _scale = 1.0);
  },
  onTapCancel: () {
    setState(() => _scale = 1.0);
  },
  child: AnimatedScale(
    scale: _scale,
    duration: Duration(milliseconds: 100),
    curve: Curves.easeOut,
    child: Container(/* 按钮内容 */),
  ),
)
```

---

## 图片使用指南

### 产品摄影要求

1. **高清晰度**: 至少 2x 分辨率 (2000px+)
2. **纯净背景**: 白色或浅驼色单色背景
3. **45° 角度**: 产品斜向摆放,营造立体感
4. **自然光照**: 柔和侧光,避免硬阴影
5. **细节清晰**: 能看清咖啡豆纹理、拉花细节

### 图片格式

- 产品图: PNG (透明背景)
- 场景图: WebP (高压缩比)
- 图标: SVG (矢量)

---

## 响应式适配

### 断点

- 小屏手机: < 375px
- 标准手机: 375px - 428px
- 大屏手机/折叠屏: > 428px
- 平板: > 600px

### 适配策略

- **产品瓦片**: 垂直 padding 从 64 → 48 (小屏)
- **标题**: heroDisplay 56px → 40px (小屏)
- **网格**: 2列 → 1列 (< 375px)
- **按钮**: 保持 48px 最小高度(触摸目标)

---

## 无障碍 (Accessibility)

- **最小点击区域**: 48×48 dp
- **色彩对比度**: 主色与白色对比度 > 4.5:1
- **语义化**: 正确使用 Semantics widget
- **字体缩放**: 支持系统字体大小设置

---

## 性能优化

1. **图片懒加载**: 使用 `cached_network_image`
2. **列表优化**: `ListView.builder` 而非 `ListView`
3. **动画**: 优先使用 `AnimatedContainer` 而非手动 `AnimationController`
4. **避免重建**: 合理使用 `const` 构造函数

---

## 设计检查清单

开发前自查:
- [ ] 是否使用了单一强调色 (咖啡棕)?
- [ ] 标题是否使用负字间距?
- [ ] 正文是否为 17px?
- [ ] 产品图是否加了阴影?卡片是否没加?
- [ ] 按钮是否为胶囊形状?
- [ ] 明暗瓦片是否交替出现?
- [ ] 留白是否充足?

---

## 总结

这套设计系统将 Apple 的克制美学应用于咖啡品牌 app,核心是:

1. **摄影优先** - UI 为产品让路
2. **单一强调色** - 咖啡棕贯穿所有交互
3. **负空间** - 大量留白让内容呼吸
4. **精准字阶** - 17px 正文 + 负字间距标题
5. **克制动效** - 仅在关键时刻出现

记住:少即是多。每一个像素都要有目的。
