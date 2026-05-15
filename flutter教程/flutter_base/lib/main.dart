//启动Flutter应用使用runApp方法
//runApp方法中需要传入一个widget
//Widget是组成Flutter的重要一部分，万物皆widget
//Material风格是Flutter内置的一套独有的设计风格，里面有很多拆箱可用的Widget
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Flutter组件",
      theme: ThemeData(scaffoldBackgroundColor: Colors.red),
      home: Scaffold(),
    ),
  );
}
//特性:整个应用被MaterialApp包裹，方便我们对整个应用的属性进行整体设计
//常见属性:title/theme/home
//title:用来展示窗口的标题内容(可以不设置)
//theme:用来设置整个应用的主题
//home:用来展示窗口的主体内容
////////////////////////////
//Scaffold:用于构建Material Design风格页面的核心布局组件，提供标准、灵活配置的页面骨架
//属性                      主要作用说明
//appBar                     页面顶部的应用栏，通常用于显示标题、导航按钮和操作菜单
//body                       页面的主要内容区域，可以放置任何其他组件，是页面的核心
//bottomNavigationBar        底部导航栏，方便用户在不同核心功能页面间切换
//backgroungColor            设置整个Scaffold的背景颜色
//floatingActionButton       悬浮操作按钮，常用于触发页面的主要动作