import 'dart:io';
//소켓이나 http 서버와 통신할때 사용

void main(){
  showData();
}

showData(){
  startTask();
  accessData();
  fetchData();
}


startTask(){
  String info1 = 'start';
  print(info1);
}
accessData(){
  Duration time = Duration(seconds: 3);
  sleep(time);
  String info2 = 'access';
  print(info2);
}
fetchData(){
  String info3 = 'fetch';
  print(info3);
}