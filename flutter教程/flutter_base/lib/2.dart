// // Flutter自定义组件-无状态组件和有状态组件
// // ●定义:根据自己特定的需求创建自己的Widget
// // ●分类:Flutter分为无状态组件和有状态组件
// // 特性              Statelesswidget(无状态)            Statefulwidget(有状态)
// // 核心特征           一旦创建,内部状态不可变            持有可在其生命周期内改变的状态
// // 使用场景           静态内容展示,外观仅由配置参数决定   交互式组件,如计数器、可切换开关、表单输入框
// // 生命周期            相对简单,主要是构建(build)        更为复杂,包含状态创建、更新和销毁
// // 代码结构                   单个类                    两个关联的类:Widget本身和单独的State类

// //无状态组件-StatelessWidget
// // ●定义:创建一个新的类,继承StatelessWidget类并实现build方法
// // ●要点:build返回一个Widget
// // ● 场景:纯展示型组件,没有用户交互操作
// // 需求:把之前案例的骨架换成无状态组件
// // import 'package:flutter/material.dart';

// // void main() {
// //   runApp(MainPage());
// // }

// // //无状态组件-自定义组件中的一种
// // class MainPage extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     // TODO: implement build
// //     return MaterialApp(
// //       title: "Flutter组件初体验-无状态组件",
// //       home: Scaffold(
// //         appBar: AppBar(title: Text("头部区域")),
// //         body: Container(child: Center(child: Text("主体区域"))),
// //         bottomNavigationBar: Container(
// //           height: 80,
// //           child: Center(child: Text("底部区域")),
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MainPage());
// }
// ////////////////////////////////////////
// // 有状态组件-StatefulWidget

// // ●定义:有状态组件是构建动态交互界面的核心,能够管理变化的内部状态,当状态改变时,组件会更新显示内容
// // ●实现1:创建两个类,第一个类继承StatefulWidget类,主要接收和定义最终参数,核心作用是创建State对象
// // ●实现2:第二个类继承State<第一个类名>,负责管理所有可变的数据和业务逻辑,并实现build构建方法
// // ●要点:build方法需要返回一个Widget
// // ●需求:将之前骨架组件换成有状态组件
// class MainPage extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _MainPageState();
//     //return 第二个类的对象
//     // TODO: implement createState
//   }

//   //第二个类 内部类 负责管理数据 处理业务逻辑 并且渲染视图
// }

// class _MainPageState extends State<MainPage> {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return MaterialApp(
//       title: "Flutter组件初体验-有状态组件",
//       home: Scaffold(
//         appBar: AppBar(title: Text("头部区域")),
//         body: Container(child: Center(child: Text("主体区域"))),
//         bottomNavigationBar: Container(
//           height: 80,
//           child: Center(child: Text("底部区域")),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

//////////////////////////////////////////////////
//●无状态组件快捷键:statelessW

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

//● 有状态组件快捷键:statefulW
class _TestWidget extends StatefulWidget {
  const _TestWidget({super.key});

  @override
  State<_TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<_TestWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
