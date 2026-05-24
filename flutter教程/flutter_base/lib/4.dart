// //事件-组件点击事件
// // ●组件:Flutter提供了多种方式为组件添加点击交互
// // 组件类别                 核心组件                            主要特点/使用场景
//
// // 专用按钮组件       ElevatedButton, TextButton,            内置点击动画和样式,通过onPressed参数处理点击逻辑
// //                 OutlineButton, FloatingActionButton
// //
// // 视觉反馈组件          Inkwell                             提供点击事件(onTap),有MaterialDesign风格的水纹扩散效果
// //
// // 其他交互组件         IconButton, Switch, Checkbox            具有特定功能的交互式控件、点击事件(onPressed)
// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MainPage());
// }
//
// class MainPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return MaterialApp(
//       title: "Flutter组件",
//       home: Scaffold(
//         appBar: AppBar(title: Text("头部区域")),
//
//         body: Container(
//           child: Center(
//             child: TextButton(
//               onPressed: () {
//                 print("按钮的点击事件");
//               },
//               child: Text("按钮"),
//               //     child: GestureDetector(
//               //         //点击事件
//               //       onTap: () {
//               //         print("点击了该区域");
//               //       },
//               //       child: Text("主体区域"),
//             ),
//           ),
//         ),
//         bottomNavigationBar: Container(
//           height: 80,
//           child: Center(child: Text("底部区域")),
//         ),
//       ),
//     );
//   }
// }
//
//状态更新-setState
//●场景:计数器,点击+进行数量+1,点击-进行数量-1,UI视图需要进行相应更新。
//●语法:数据的变化要更新UI视图,需要执行setState方法,setState方法会造成build的重新执行。
import 'package:flutter/material.dart';

void main() {
  runApp(MainPage());
}

//有状态组件
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Row(
            children: [
              TextButton(
                onPressed: () {
                  setState(() {//实时
                    count -= 1;
                    print(count);
                  });
                },
                child: Text("减"),
              ),
              Text(count.toString()),
              TextButton(
                onPressed: () {
                  setState(() {
                    count += 1;
                    print(count);
                  });
                },
                child: Text("加"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
