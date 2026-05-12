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
//定义:Dart中的类的是指同一操作作用于不同的对象，可以产生不同的执行效果
//场景:微信和支付宝都遵循同样支付接口，但实现逻辑不同，即同一个支付操作拥有不同的支付效果
//实现方式:1.继承和方法重写、2.抽象类和接口
//需求:定义一个父类，分别实现微信和支付宝支付类，重写得到不同的支付逻辑
// void main(){
//  PayBase wx=wxpay();
//  wx.pay();   
//  PayBase ali=alipay();
//  ali.pay();
// }
// 基础支付类
// class PayBase{
//     void pay(){
//         print("基础支付");

// }}
// //微信支付类
// class wxpay extends PayBase{
//     @override
//     void pay(){
// print("微信支付");
//     }
// }
// //支付宝支付类
// class alipay extends PayBase{
//     @override
//     void pay(){
// print("支付宝支付");
//     }
// }
//中国银行支付类
//方式:使用abstract关键字声明一个抽象类(没有实现体)
//方式:使用implements关键字继承并实现抽象类
// void main(){
//     PayBase bank=bankpay();
//     bank.pay();
// }
// abstract class PayBase{
//     void pay();
// }
// class bankpay implements PayBase{
//     @override
//     void pay(){
// print("中国银行支付");
//     }
// }
///////////////////////////////////////////////////
//定义:Dart允许在不使用传统继承的情况下，向类中添加新的功能
//方式:使用mixin关键字定义一个对象
//方式:使用with关键字将定义的对象混入到当前对象
//特点:一个类支持with多个mixin，调用优先级遵循“后来居上”原则，即后混入的会覆盖先混入的同名方法
//需求:让一个学生类和一个老师类都拥有唱歌的方法
// void main() {
//   // 学生对象
//   Student s = Student(name: "小张同学");
//   s.sing(s.name!); 
//   // 老师对象
//   Teacher t = Teacher(name: "小李老师");
//   t.sing(t.name!);
// }
// mixin Sing {
//   void sing(String name) {
//     print("$name在唱歌");
//   }
// }
// // 学生类
// class Student with Sing {
//   String? name;
//   int? age;
//   // 构造方法
//   Student({this.name, this.age});
// }
// // 老师类
// class Teacher with Sing {
//   String? name;
//   int? age;
//   // 构造方法
//   Teacher({this.name, this.age});
// }
///////////////////////////////////////////////////////////////
//dart中泛型 或者Map
list list=[];
list.add("");
list.add(123);
list.add(true);
list.add([]);