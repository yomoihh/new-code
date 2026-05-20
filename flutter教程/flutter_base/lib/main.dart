import 'package:flutter/material.dart';

void main() {
  runApp(MainPage());
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Flutter组件",
      home: Scaffold(
        appBar: AppBar(title: Text("头部区域")),

        body: Container(
          child: Center(
            child: GestureDetector(
                //点击事件 
              onTap: () {
                print("点击了该区域");
              },
              child: Text("主体区域"),
            ),
          ),
        ),

        bottomNavigationBar: Container(
          height: 80,
          child: Center(child: Text("底部区域")),
        ),
      ),
    );
  }
}
