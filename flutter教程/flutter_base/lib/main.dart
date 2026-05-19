// Flutter自定义组件-无状态组件和有状态组件
// ●定义:根据自己特定的需求创建自己的Widget
// ●分类:Flutter分为无状态组件和有状态组件
// 特性              Statelesswidget(无状态)            Statefulwidget(有状态)
// 核心特征           一旦创建,内部状态不可变            持有可在其生命周期内改变的状态
// 使用场景           静态内容展示,外观仅由配置参数决定   交互式组件,如计数器、可切换开关、表单输入框
// 生命周期            相对简单,主要是构建(build)        更为复杂,包含状态创建、更新和销毁
// 代码结构                   单个类                    两个关联的类:Widget本身和单独的State类

//无状态组件-StatelessWidget
// ●定义:创建一个新的类,继承StatelessWidget类并实现build方法
// ●要点:build返回一个Widget
// ● 场景:纯展示型组件,没有用户交互操作
// 需求:把之前案例的骨架换成无状态组件
import 'package:flutter/material.dart';

void main() {
  runApp(MainPage());
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Flutter组件初体验-无状态组件",
      home: Scaffold(
        appBar: AppBar(
          title: Text("头部区域"),
        ),
        body: Container(
          child: Center(
            child: Text("主体区域"),
          ),
        ),
        bottomNavigationBar: Container(
          height: 80,
          child: Center(
            child: Text("底部区域"),
          ),  
        ),
      ),
    );
  }
}
