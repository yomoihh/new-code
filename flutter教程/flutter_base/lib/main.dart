import 'package:flutter/material.dart';
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
  TextEditingController _usernameController =
      TextEditingController(); //用户名输入控制器
  TextEditingController _passwordController = TextEditingController(); //密码输入控制器
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("登录")),
        body: Container(
          padding: EdgeInsets.all(20),
          color: Colors.white,
          child: Column(
            children: [
              TextField(
                onChanged: (value) {
                  print("用户名输入变化：$value");
                },
                onSubmitted: (value) {
                  print("用户名输入提交：$value");
                },
                controller: _usernameController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 15,
                  ),
                  hintText: "请输入用户名",
                  labelText: "用户名",
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.white, width: 2),
                  ),
                ),
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "请输入密码",
                  labelText: "密码",
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.white, width: 2),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: TextButton(
                  onPressed: () {
                    // 只改这一行，剩下全部和你原来一模一样
                    print(
                      "登录-${_usernameController.text}-${_passwordController.text}",
                    );
                  },
                  child: Text("登录"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
