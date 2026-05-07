// void main() {
//const 表达式里的值不允许有变量值
//   const num =3.1415926;
//   const length=2 *num *10;
// print(length);

//final常量声明，当我们需要当前时间作为唯一的操作时间
// final time=DateTime.now();
// print(time);

//存储一个不变的数据，在编译时就确定用const声明常量，在运行时才确定用final声明常量

//   var str='niok';
//   var nyname='123';
//   print(str);
//   print(nyname);
// }

//字符串
//   String str = '你好';
//   print(str);
//   str='你也好';
//   print(str);
//   //我要在当前的时间吃饭
//   String content='我要在${DateTime.now()}吃饭';
//   print(content);
//   String flag ="张三";
//   String content1='我和$flag是好朋友';
//   print(content1);

//数字类型 int-整型数字 num 可整型可小数 double 小数
//  int friendcount=3;
//  print('我有$friendcount个朋友');
//  num rest=1.5;
//  print('我有$rest个月的假期');
//  double applecount=4.5;
//  print('我买了$applecount斤苹果');
// // friendcount=applecount;//不允许直接赋值
// // frinedcount =appcount.toInt();
// applecount=friendcount.toDouble();
// applecount=rest.toDouble();//num可以直接转换为double给double赋值
//   rest=applecount;//double可以直接给num赋值
//
//布尔类型bool
// bool isfinishwork =false;
// print('同学当前的作业状态是$isfinishwork');
// isfinishwork=true;
// print('同学当前的作业状态是$isfinishwork');

//列表类型List
//在尾部添加-add(内容）
//在尾部添加一个列表-addAll(列表）
//删除满足内容的第一个-remove(内容）
//删除最后一个-removeLast()
//删除索引范围内数据-removeRange(start,end)
//   List tooyle = ['jee', 'jamyoung', 'attactk', 'master', 'danking'];
//   print(tooyle);
//   tooyle.add("niko");
//   print(tooyle);
//   tooyle.addAll(['野牛教主', '电击小子']);
//   print(tooyle);
//   tooyle.remove('jee');
//   print(tooyle);
//   tooyle.removeLast();
//   print(tooyle);
//   tooyle.removeRange(4, 6);
//   print(tooyle);

//List的常用操作方法和属性
//循环-forEach((item){});
// 是否都满足条件-every((item){return布尔值});
// 筛选出满足条件的数据-where((item){return布尔值}));
// 列表的长度(属性)-length
// 最后一个元素(属性)-last
// 第一个元素(属性)-first
// 是否为空(属性)-isEmpty
//   tooyle.forEach((item) {
//     print(item);
//   });
//
//   print(tooyle.every((item){S
//     return item.toString().startsWith('j');
//   }));
//
//   print(tooyle.where((item){
//     return item.toString().startsWith('j');
//   }));
//   print(tooyle.length);
//   print(tooyle.last);
//   print(tooyle.first);
//   print(tooyle.isEmpty);
// }
/////////////////////////////////////////////////////////////////////////////////
//字典Map 使用场景：当存储的英文需要找到对应的中文描述，需要使用键值对类型map
// void main() {
//   Map transmap = {"lunch": '午饭', "morning": '早上好', "apple": '苹果'};
//   print(transmap);
//   print(transmap['morning']);
//   transmap['apple'] = '玉米';
//   print(transmap['apple']);
//   //map常用操作方法
//   //循环forEach，
//   // 添加一个字典addAll，
//   // 是否包含某个key -containsKey
//   //删除某个key -remove ，
//   // 清空-clear
//   transmap.forEach((key, value) {
//     print("$key,$value");
//   });
//
//   transmap.addAll({"fish":'鱼肉'});
//   print(transmap);
//
//   print(transmap.containsKey("donkey"));
//
//   transmap.remove("fish");
//   print(transmap);
//
//   transmap.clear();
//   print(transmap);
// }
///////////////////////////////////////////////////////////
//动态类型-dynamic
// //允许变量运行时自由改变类型，同时绕过编译时的静态检查
// void main(){
// dynamic free="字符串";
// free=1;
// free=[];
// free=false;
// free={};
//dynamic和var的区别，dy编译不会检查类型 可以直接调用，var会
