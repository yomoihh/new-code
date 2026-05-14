//dart中异步编程-事件循环
// 介绍:Dar是单线程语言，即同时只能做一件事，遇到耗时任务就会造成程序阻塞，此时需要异步编程
//定义:Dart采用单线程+事件循环的机制完成耗时任务的处理
//事件循环:
//执行同步代码=>执行微任务队列=>执行事件队列=>结束
// 微任务队列:Future.microtask()
// 事件队列:Future、Future.delayed()、I/0操作(文件、网络)等
////////////////////////////////////////////////////////////////////
//dart中异步编程-Future
// 介绍:Future代表一个异步操作的最终结果.
// 状态: Uncompleted (等待)Completed with a value (成功), Completed with a error(失败)
// 创建:Future((){})
// 执行成功:不抛出异常-成功状态-then((){})
// 执行失败:throw Exception()-失败状态-catchError((){})
// void main(){
// Future f= Future((){
//     // return "hello future";
// //没有蹦出异常 都是成功状态
// throw Exception("错误");
// });
// //then中接收成功状态
// f.then((value){
//     print(value);
// });
// f.catchError((error){
//     print("出现错误了");
// });
// }
//////////////////////////////////////////////////
//Future链式调用
// 介绍:Future可以通过链式的方式连续得到异步的结果
// 语法:通过Future().then()拿到执行成功的结果
// 语法:通过Future().catchError()拿到执行失败的结果
// 注意:在上一个then返回对象会在下一个then中接收
// 需求:执行三个异步任务，按照顺序排列，最后一次任务抛出异常
// void main(){
//     Future f=Future((){
//         return "hello future";
//     });
//     f.then((value){
//         return Future(( )=>"task1");
//     }).then((value){
//         return Future(()=>"$value-task2");
//     }).then((value){
//         return Future(()=>"$value-task3");
//     }).then((value){
//         print(value);
//         throw Exception("异常");
//     }).catchError((error){
//         print("出现错误了");
//     });
// }
/////////////////////////////////////////
//Future-async/await
// 介绍:除了通过then/catchError的方式，还可以通过async/await来实现异步编程
// 特点:await总是等到后面的Future执行成功，才执行下方逻辑，async必须配套await出现
// 语法:
// 函数名()async{
// try{
// await Future();
// //Future执行成功才执行的逻辑
// }
// catch(error){
// //执行失败的逻辑
// }
// }
void main(){
 test();
}
void test() async{
  try{
 String result = await Future((){
  return "测试";
  // throw Exception("错误");
});
// await Future.delayed(Duration(seconds:3));
//awit总是等到Future执行成功才执行下方逻辑
print(result);
}catch(e){
  print("异步请求出现异常");
}
}