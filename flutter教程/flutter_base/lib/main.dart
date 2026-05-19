// 组件生命周期-无状态组件
// ●无状态组件-唯一阶段
// build方法
// ●当组件被创建或父组件状态变化导致其需要重新构建时,build方法会被调用
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MainPage());
// }

// class MainPage extends StatelessWidget {
//   const MainPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     print("无状态组件的构建函数");
//     return MaterialApp(
//       home: Scaffold(
//         body: Container(child: Center(child: Text("无状态组件"))),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

//////////////////////////////////////
//组件生命周期-有状态组件
// 生命周期阶段                 函数名         调用时机与核心任务

//                      createState()        Widget初始化调用,创建State对象
// 创建阶段            initState()          State对象插入Widget树立刻执行,仅执行一次
//             didChangeDependencies()   initState后立刻执行,当所依赖的InheritedWidget更新时调用,可能多次

// 构建与更新阶段        build()               构建UI方法,初始化或更新后多次调用
//                      didUpdateWidget()   父组件传入新配置时调用,用于比较新旧配置

// 销毁阶段           deactiveate()      当State对象从树中暂时移除时调用
//                    dispose()         当State对象被永久移除时调用,释放资源,仅执行一次

void main() {
  runApp(MainPage());
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() {
    print("createState阶段执行");
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    print("initState阶段执行");
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container();
  }
}
