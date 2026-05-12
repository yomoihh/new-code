// // //Dart中类的继承
// // 定义:继承是拥有父类的属性和方法
// // 特点:dart属于单继承，一个类只能拥有一个直接父类，子类拥有父类所有的属性和方法
// // 语法:class类名extends父类
// // 重写:子类可通过@override注解重写父类方法，扩展其行为
// // 注意:子类不会继承父类构造函数，子类必须通过super关键字调用父类构造函数确保父类正确初始化
// // super语法:子类构造函数(可选命名参数):super({参数})
// void main(){
//   Child c=Child(name: '朱朱',age:20);
//   c.study();
// }
// class Parent{
//   String?name;
//   int? age;
//   Parent({this.name,this.age});
//   void study(){
//     print("父类-$name在学习");
//   }
// }
// //子类继承父类
// class Child extends Parent {
//   Child({String? name, int? age}) :super(name: name, age: age);
// @override
//   void study(){
//     // TODO: implement ==
//   super.study();//先调用了父类的方法
//   print("子类-$name在学习");
//   }
// }
//////////////////////////////////////////////////
//dart中类的多态-继承和方法重写
