//弹性布局
import 'package:flutter/material.dart';

void main() {
  runApp(MainPage());
}

//List.generate是一个构造器,用于快速创建长度固定且每个元素可以通过索引号确定的列表
//语法:List.generate(int count, E generator(int index),{bool growable: false})
class MainPage extends StatelessWidget {
  const MainPage({super.key});
  List<Widget> getlist() {
    return List.generate(10, (index) {
      return Container(width: 100, height: 100, color: Colors.blue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("wrap代码示例")),
        //   body: Container(
        //     width: double.infinity, //正无穷大
        //     height: double.infinity, //正无穷大
        //     decoration: BoxDecoration(color: Colors.red),
        //     child: Flex(
        //       direction: Axis.horizontal, //水平方向
        //       children: [
        //         Expanded(flex:1, child: Container(width: 100, height: 100, color: Colors.green)),
        //         Expanded(flex:2,child: Container(width: 100, height: 100, color: Colors.yellow)),
        //         Expanded(flex:3,child: Container(width: 100, height: 100, color: Colors.blue)),
        // ],
        //     ),
        //   ),
        // ),
        // body: Container(
        //   color: Colors.amber,
        //   width: double.infinity,
        //   height: double.infinity,
        //   //   child:Flex(direction: Axis.vertical,
        //   //   children: [
        //   //    Container(color: Colors.blue,
        //   //    height: 100,),
        //   //     Expanded(child:  Container(color: Colors.blueGrey),),
        //   //     Container(color: Colors.red,height: 100,),
        //   //   ],
        //   //   )
        //   // )
        //   child: Wrap(
        //     spacing: 10,
        //     runSpacing: 10,
        //     alignment: WrapAlignment.spaceAround,
        //     direction: Axis.horizontal,
        //     children: getlist(),
        //   ),
        // ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          color: Colors.grey,

          //   child: Stack(
          //     //层叠布局,后者覆盖前者
          //     alignment: Alignment.center,
          //     children: [
          //       Container(color: Colors.red, width: 200, height: 200),
          //       Container(color: Colors.blue, width: 100, height: 100),
          //       Container(color: Colors.green, width: 50, height: 50),
          //       Container(color: Colors.yellow, width: 30, height: 30),
          //     ],
          //   ),
          // ),

          //   child: Stack(
          //     children: [
          //       Container(width: 200, height: 200, color: Colors.grey),
          //       Positioned(
          //         top: 10,
          //         left: 10,
          //         child: Container(width: 100, height: 100, color: Colors.red),
          //       ),
          //       Positioned(
          //         bottom: 10,
          //         right: 10,
          //         child: Container(width: 100, height: 100, color: Colors.blue),
          //       ),
          //     ],
          //   ),
          // child: Text(
          //   "hello Flutter!",
          //   style: TextStyle(
          //     fontSize: 20,
          //     color: Colors.white,
          //     fontStyle: FontStyle.italic,
          //     fontWeight: FontWeight.w900,
          //     decoration: TextDecoration.underline,
          //     decorationColor: Colors.black,
          //   ),
          // ),//基本样式
          //////////
          ///文本超出
          // child: Text(
          //   "有什么我能帮你的吗？热点：云南中专小伙 10 天 3000 元 AI 短片《丧尸清道夫》火爆全网胃真的越撑越大，越饿越小吗？最新的显卡评测哪款值得推荐？分享一些关于 Java 编程的高级技巧资讯：中央气象台发布 6 号台风“蔷薇”蓝色预亮氨酸如何助力肌肉生长？随身WiFi和流量卡哪个更方便？三角形接法在电力系统中的应用？",
          //   style: TextStyle(color: Colors.white, fontSize: 20),
          //   maxLines: 3,
          //   overflow: TextOverflow.ellipsis,
          // ),

          //文本组件-TextSpan
          // child: Text.rich(
          //   TextSpan(
          //     text: "hello",
          //     children: [
          //       TextSpan(
          //         text: "Flutter",
          //         style: TextStyle(
          //           color: Colors.white,
          //           fontSize: 20,
          //           fontWeight: FontWeight.bold,
          //         ),
          //         children: [
          //           TextSpan(
          //             text: "!",
          //             style: TextStyle(
          //               color: Colors.red,
          //               fontSize: 20,
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ],
          //     style: TextStyle(
          //       color: Colors.yellow,
          //       fontSize: 20,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),//本地图片
          // child: Image.asset(
          //   "lib/images/1.jpg",
          //   width: 200,
          //   height: 200,
          //   // fit: BoxFit.cover,
          //   // fit: BoxFit.contain,
          //   // fit: BoxFit.fill,
          //   fit: BoxFit.fitWidth,
          // ),
          //网络图片
          child: Image.network(
            "https://pic4.zhimg.com/v2-c34c61a90095abb8713de9d1dca7ec7b_r.jpg",
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
