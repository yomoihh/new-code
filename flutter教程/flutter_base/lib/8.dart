import 'package:flutter/material.dart';

void main() {
  runApp(MainPage());
}

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  late PageController _outerPageController;

  @override
  void initState() {
    super.initState();
    _outerPageController = PageController();
  }

  @override
  void dispose() {
    _outerPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("登录")),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Stack(
                children: [
                  Container(
                    color: Colors.amber,
                    alignment: Alignment.center,
                    height: 200,
                    child: PageView.builder(
                      controller: _outerPageController,
                      physics: const PageScrollPhysics(),
                      itemCount: 10,
                      onPageChanged: (int index) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      itemBuilder: (BuildContext context, int outerIndex) {
                        return Container(
                          alignment: Alignment.center,
                          child: PageView.builder(
                            itemCount: 10,
                            itemBuilder: (BuildContext context, int innerIndex) {
                              return Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "轮换图 ${outerIndex + 1}",
                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(10, (index) {
                          return GestureDetector(
                            onTap: () {
                              _outerPageController.animateToPage(
                                index,
                                duration: Duration(seconds: 1),
                                curve: Curves.linear,
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 10),
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: _currentIndex == index
                                    ? Colors.blue
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 10)),
            SliverPersistentHeader(
              pinned: true,
              delegate: _StickyCategoryDelegate(),
            ),
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              delegate: SliverChildBuilderDelegate(
                    (context, index) => Container(
                  color: Colors.blue.shade200,
                  alignment: Alignment.center,
                  child: Text('商品 ${index + 1}'),
                ),
                childCount: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StickyCategoryDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent,
      ) {
    return Container(
      color: Colors.white,
      height: maxExtent,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: 30,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: 100,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            color: Colors.blue,
            alignment: Alignment.center,
            child: Text(
              "分类${index + 1}",
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          );
        },
      ),
    );
  }

  @override
  double get maxExtent => 100;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
// body: ListView.builder(
//   itemCount: 100, //列表的长度
//   itemBuilder: (BuildContext context, int index) {
//     return Container(
//       margin: EdgeInsets.only(top: 10),
//       color: Colors.amber,
//       width: double.infinity,
//       height: 80,
//       child: Text(
//         '第${index + 1}个',
//         style: TextStyle(color: Colors.white, fontSize: 30),
//       ),
//       alignment: Alignment.center,
//     );
//   },
// ),
// body: ListView.separated(
//   itemCount: 120, // 列表的长度（原注释保留）
//   itemBuilder: (BuildContext context, int index) {
//     return Container(
//       // margin: EdgeInsets.only(top: 10),
//       color: Colors.amber,
//       width: double.infinity,
//       height: 80,
//       child: Text(
//         '第${index + 1}个',
//         style: TextStyle(color: Colors.white, fontSize: 30),
//       ),
//       alignment: Alignment.center,
//     );
//   },
//   separatorBuilder: (BuildContext context, int index) {
//     return Container(
//       height: 10,
//       width: double.infinity,
//       color: Colors.red,
//     ); // 无分隔线
//   },
// ),
// body: GridView.count(
//   scrollDirection: Axis.vertical,
//   padding: EdgeInsets.all(10),
//   crossAxisCount: 4, // 每行3列
//   mainAxisSpacing: 10,
//   crossAxisSpacing: 10,
//   children: List.generate(100, (int index) {
//     return Container(
//       color: Colors.blue,
//       child: Text(
//         "${index + 1}",
//         style: TextStyle(color: Colors.white, fontSize: 20),
//       ),
//       alignment: Alignment.center, // 让文本居中
//     );
//   }),
// ),

// body: GridView.extent(
//   scrollDirection: Axis.horizontal,
//   padding: EdgeInsets.all(10),
//   maxCrossAxisExtent: 200, //设置子项最大高度
//   mainAxisSpacing: 10,
//   crossAxisSpacing: 10,
//   children: List.generate(100, (int index) {
//     return Container(
//       color: Colors.blue,
//       child: Text(
//         "${index + 1}",
//         style: TextStyle(color: Colors.white, fontSize: 20),
//       ),
//       alignment: Alignment.center, // 让文本居中
//     );
//   }),
// ),

//●作用:使用GridView.builder实现动态长网格-(懒加载,只渲染可见区域)
//●注意:接收gridDelegate布局委托、itemBuilder构建函数、itemCount构建数量
// body: GridView.builder(
//   //按照列数去固定
//   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//     crossAxisCount: 4,
//     mainAxisSpacing: 10,
//     crossAxisSpacing: 10,
//     childAspectRatio: 2,
//   ),
//   itemCount: 100,
//   itemBuilder: (BuildContext context, int index) {
//     return Container(
//       color: Colors.blue,
//       child: Text(
//         "${index + 1}",
//         style: TextStyle(color: Colors.white, fontSize: 20),
//       ),
//       alignment: Alignment.center, // 让文本居中
//     );
//   },
// ),

//常用滚动组件-GridView
// ●作用:用于创建二维可滚动网格布局的核心组件
// ●方式:提供多种构建方式,GridView.count、GridView.extent、GridView.builder等
// GridView默认构造方式-(写起来最过繁琐,很少使用)
// GridView.count-基于固定列数的网格布局(最常用之一)
// Gridview.extent-基于固定子项最大宽度/高度的网格布局(最常用之二)
// GridView.builder用于网格项数量巨大或动态生成的情况,需要接收gridDelegate布局委托属性
// ●gridDelegate: SliverGridDelegateWithFixedCrossAxisCount:固定列数 mainAxisSpacing 主轴间距
// SliverGridDelegateWithMaxCrossAxisExtent:最大宽度 crossAxisSpacing 交叉轴间距
// scrollDirection设置滚动方向横向/纵向(默认)