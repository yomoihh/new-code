import 'package:flutter/material.dart';
// 原代码中导入了 dart:math，虽然未使用，这里保留以示尊重
import 'dart:math' as math;

void main() {
  runApp(MainPage());
}

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // ---------- 以下是您原有的控制器 ----------
  TextEditingController _usernameController =
      TextEditingController(); //用户名输入控制器
  TextEditingController _passwordController = TextEditingController(); //密码输入控制器
  ScrollController _controller = ScrollController(); //滚动控制器

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("登录")), // 原标题未改，下方实际演示滚动列表
        // ---------- 您原先注释掉的登录表单（完整保留） ----------
        // body: Container(
        //   padding: EdgeInsets.all(20),
        //   color: Colors.white,
        //   child: Column(
        //     children: [
        //       TextField(
        //         onChanged: (value) {
        //           print("用户名输入变化：$value");
        //         },
        //         onSubmitted: (value) {
        //           print("用户名输入提交：$value");
        //         },
        //         controller: _usernameController,
        //         decoration: InputDecoration(
        //           contentPadding: EdgeInsets.symmetric(
        //             horizontal: 10,
        //             vertical: 15,
        //           ),
        //           hintText: "请输入用户名",
        //           labelText: "用户名",
        //           fillColor: Colors.white,
        //           filled: true,
        //           border: OutlineInputBorder(
        //             borderRadius: BorderRadius.all(Radius.circular(10)),
        //             borderSide: BorderSide(color: Colors.white, width: 2),
        //           ),
        //         ),
        //       ),
        //       TextField(
        //         controller: _passwordController,
        //         obscureText: true,
        //         decoration: InputDecoration(
        //           hintText: "请输入密码",
        //           labelText: "密码",
        //           fillColor: Colors.white,
        //           filled: true,
        //           border: OutlineInputBorder(
        //             borderRadius: BorderRadius.all(Radius.circular(10)),
        //             borderSide: BorderSide(color: Colors.white, width: 2),
        //           ),
        //         ),
        //       ),
        //       SizedBox(height: 20),
        //       Container(
        //         height: 50,
        //         width: double.infinity,
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.all(Radius.circular(10)),
        //         ),
        //         child: TextButton(
        //           onPressed: () {
        //             // 只改这一行，剩下全部和你原来一模一样
        //             print(
        //               "登录-${_usernameController.text}-${_passwordController.text}",
        //             );
        //           },
        //           child: Text("登录"),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),

        // ---------- 当前实际使用的滚动列表 + 悬浮按钮（已修正滚动逻辑） ----------
        body: Stack(
          children: [
            SingleChildScrollView(
              controller: _controller, // 将滚动控制器关联到 SingleChildScrollView
              padding: EdgeInsets.all(20),
              child: Column(
                children: List.generate(100, (index) {
                  return Container(
                    margin: EdgeInsets.only(top: 10), // 每个容器之间添加垂直间距
                    width: double.infinity,
                    height: 50,
                    color: Colors.blue,
                    alignment: Alignment.center,
                    child: Text(
                      "我是第 ${index + 1} 个", // 动态显示索引，避免重复内容
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  );
                }),
              ),
            ),

            // ---------- 去底部按钮（原代码有错误，已修正） ----------
            // 原错误：_controller.animateTo(0) 会滚动到顶部，应滚动到底部
            // 修正：使用 _controller.position.maxScrollExtent
            Positioned(
              right: 10,
              // 原代码缺 top/bottom，导致按钮默认贴在左上角；这里增加 top 使其独立于底部按钮
              top: 20,
              child: GestureDetector(
                onTap: () {
                  // 修正：滚动到底部（原为滚动到顶部，现已改对）
                  if (_controller.hasClients) {
                    _controller.animateTo(
                      _controller.position.maxScrollExtent, // 滚动到最大距离即底部
                      duration: Duration(seconds: 4),
                      curve: Curves.bounceIn,
                    );
                  }
                  print("点击了去底部按钮");
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  height: 50,
                  width: 88,
                  child: Text(
                    "去底部",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),

            // ---------- 去顶部按钮（原逻辑正确，但缺少位置限定，已补充 bottom） ----------
            Positioned(
              right: 10,
              bottom: 20, // 固定在右下角
              child: GestureDetector(
                onTap: () {
                  // 滚动到顶部，原代码为 _controller.jumpTo(0)，现在增加动画提升体验
                  _controller.animateTo(
                    0,
                    duration: Duration(seconds: 1),
                    curve: Curves.bounceIn,
                  );
                  print("点击了去顶部按钮");
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  height: 50,
                  width: 88,
                  child: Text(
                    "去顶部",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 下面这些是您原文件中遗留的注释和未使用的代码片段，一并保留（仅为尊重原文）
//       height: 50,
//       color: Colors.blue,
//       alignment: Alignment.center,
//       child: Text(
//         "我是第 ${index + 1} 个", // 动态显示索引，避免重复内容
//         style: TextStyle(color: Colors.white, fontSize: 20),
//       ),
//     );
//   }),
// ),

//   Container(
//     width: double.infinity,
//     color: Colors.blue,
//     height: 200,
//     alignment: Alignment.center,
//     child: Text(
//       "第一个",
//       style: TextStyle(color: Colors.white, fontSize: 20)),
//     ),
//     alignment: Alignment.center,
//   ),
// ],
/////////////////////
///常用滚动组件-SingleChildScrollView

//●子组件:只能包含一个子组件,如果滚动多个组件,通常将其嵌套在Column或Row组件中

//●滚动方向:通过scrollDirection属性控制,默认为垂直方向(Axis.vertical),也可设置为水平方向(Axis.horizontal)

//●特点:一次性构建所有子组件,如果嵌套的Column或Row中包含大量子项,可能会导致性能问题,建议使用ListView

//●控制滚动:绑定一个ScrollController对象给controller对象,使用animateTo/jumpTo方法控制滚动

//●滚动到顶部:controller.jumpTo(0)

//●滚动到底部:controller.jumpTo(controller.position.maxScrollExtent)
