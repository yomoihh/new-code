void main() {
// //返回的类型 函数名称 参数 函数体
//  print(add(1, 2, 3,));
//  test();
// }
// int add(int a,int b,int c) {
//   return a + b + c;//有返回值
// }
//   void test(){
//     print("测试无返回值数据");//无返回值
//   }
// getValue(){//无明确类型，由dart自动推断
//   return 1+2;


  add(1, 2);
  print(combine("1"));

}
int add(int a,int b){
  return a+b;
}
//合并字符串
String combine(String a,[String? b="b",String? c="c"]){
return a+(b ?? "")+(c ?? "");
//可选位置参数必须位于必传参数后面，用中括号包裹
//函数名（string a，[string?b,...]),传递时按顺序传递

////////////////////////////////////////////////
//可选命名参数必须位于必传参数后面，采用大括号包裹

}

