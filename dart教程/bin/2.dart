void main(){
// String? username =null;//变量表示可以是null
// username?.startsWith("新");//安全访问
// //客观判断
// // username="张三";
//   //主观判断-开发者认为username一定不为null
// username!.startsWith("新");
// //要保证别人一定能够显示用户名
// String displayName = username ?? "老高";


// //dart中常见的算数运算符
// double item =10.99;
// double allPrice =item *4;
// double money =100;
// double lastmoney =money - allPrice;
// // double everymoney = lastmoney / 4;
//   int everymoney =lastmoney ~/4;
// print(everymoney);
// print (10%4);
//
//
// //赋值运算符
// double a=1;
// a +=2;//加等，a=a+2
// print(a);
// a -=1;//减等，a=a-1
//   print(a);
//   a *=2;// 乘等，a=a*2
//   print(a);
//  a /=2;//除等，a= a/2
//   print(a);



  //常见比较运算符
  int a=1;
  int b=2;
  print(a==b);
  print(a!=b);
  print(a>b);
  print(a>=b);
  print(a<b);
  print(a<=b);


  //逻辑运算符 (&同true 为true ，||有一个true为true ，！对变量取反）
  // bool isopendoor =false;
  // bool isopenlight =true;
  // //
  // print(isopendoor &&isopenlight);
  // print(isopenlight || isopendoor);
  // print(isopenlight && !isopendoor);
// //流程控制
  int score =56;
// if(score>60);
// print("恭喜你及格");
// }

// bool ismarry =false;
// if (ismarry){
//   print("恭喜你成家了");
// }else{
//   print("还没结婚呢");
// }
  if(score >80){
    print("优秀");
  }else if (score>60){
    print("及格");
  }else{
    print("不及格");
  }
//三元运算符 表达式（布尔值）？结果1:结果2;
  print(70 >= 60 ? "及格": "不及格");
//switch case语句
  int state =2;
  switch(state){
    case 1:
      print("代付款");
    case 2:
      print("已付款");
    case 3:
      print("代发货");
    case 4:
      print("已发货");
    case 5:
      print("待评价");
      break;
    default:
      print("已完成");
  }
//while和for循环语句
  while(state>1){
    print("异常");
    break;
  }
  List table =[
    "一个包子",
    "二个包子",
    "三个包子",
    "四个包子",
    "五个包子",
    "4ci测试",
  ];
  int index=0;
  while (index<table.length){
    print(table[index]);
    index += 1;

  }
}
