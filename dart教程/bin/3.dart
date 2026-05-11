// // void main() {
// // //返回的类型 函数名称 参数 函数体
// //  print(add(1, 2, 3,));
// //  test();
// // }
// // int add(int a,int b,int c) {
// //   return a + b + c;//有返回值
// // }
// //   void test(){
// //     print("测试无返回值数据");//无返回值
// //   }
// // getValue(){//无明确类型，由dart自动推断
// //   return 1+2;
//
//
//   add(1, 2);
//   print(combine("1"));
//   showPerson("泗水亭厅长刘季");
//
// }
// int add(int a,int b){
//   return a+b;
// }
// //合并字符串
// String combine(String a,[String? b="b",String? c="c"]) {
//   return a + (b ?? "") + (c ?? "");
// //可选位置参数必须位于必传参数后面，用中括号包裹
// //函数名（string a，[string?b,...]),传递时按顺序传递
//
// ////////////////////////////////////////////////
// //可选命名参数必须位于必传参数后面，采用大括号包裹
// }
//   void showPerson(String username,{int?age=18,String?sex="男"}) {
//     print('姓名:$username,性别:$sex,年龄:$age');
// //不需要写出参数值 ，无需考虑顺序/
//   /////////////////////////////////////
//     //匿名函数,可以声明一个没有名称的函数值给变量，进行调用
// // }
// void main() {
//   // text();
//   ontext(text);
//   print(add(1,2));
// }
// Function text = () {
//   print("测试");
// };
// void ontext (Function callback) {
//   callback();
// }
// /////////箭头函数
// // int add(int a,int b){
// //   return a+b;
// // }
// int add(int a,int b)=>a+b;
// //使用箭头函数可以省略return关键字
// //函数名()=>代码逻辑
//

///////////////////////////////////////////////
//dart中的类-class
// 定义:Dart语言中，类(class)是面向对象编程的核心，类包含属性和方法来定义对象的行为和状态
// 需求:定义一个Person类，属性包括姓名、年龄、性别，包括学习的方法
// 定义类语法:class Person{属性方法}
// 实例化对象:Person变量=Person();
// 属性和方法:变量.属性/方法()
// void main(){
// Person p= Person();
// p.name="老高";
// p.study();
// }
// class Person{
//   String name="";
//   int age =0;
//   String sex ="男";
//   void study(){
//     print("$name在学习");
//   }
// }
/////////////////////////////////////////////////////////
//构造函数语法糖
void main(){
Person p= Person(name:'老高',age:20,sex:'男');
p.study();
Person pp=Person(name:'小张',age:20,sex:'男');
pp.study();
Person ppp=Person.createPerson(name:'新同学',age:30);
ppp.study();
}
class Person{
  String?name="";
  int? age =0;
  String? sex ="男";
  //默认构造函数
  // Person({String? name,int? age,String?sex}){
  //   this.name= name;
  //   this.age=age;
  //   this.sex=sex;
  // }
  Person({this.age,this.name,this.sex});//语法糖写法
  //命名构造函数
  // Person.createPerson({String? name,int? age,String?sex}){
  //   this.name= name;
  //   this.age=age;
  //   this.sex=sex;
  // }
  Person.createPerson({this.sex,this.name,this.age});//语法糖写法
  void study(){
    print("$name在学习");
  }
}


