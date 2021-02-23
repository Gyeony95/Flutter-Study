import 'package:flutter/material.dart';
import 'package:half_spicy/dice.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dice game',
      home: LogIn(),
    );
  }
}

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}


class _LogInState extends State<LogIn> {

  TextEditingController controller = TextEditingController(); //입력값을 가져오기 위해서 필요함
  TextEditingController controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log in'),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {})
        ],
      ),
      body: Builder(
        builder:(context){
          return GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus();//화면 밖을 클릭시 키보드 들어감
            },
            child: SingleChildScrollView(
              //키보드가 화면 가리면 이걸로 스크롤 가능하게 함
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 50),
                  ),
                  Center(
                    child: Image(
                      image: AssetImage('image/chef.gif'),
                      width: 170.0,
                      height: 190.0,
                    ),
                  ),
                  Form(
                      child: Theme(
                        data: ThemeData(
                            primaryColor: Colors.teal,
                            inputDecorationTheme: InputDecorationTheme(
                                labelStyle:
                                TextStyle(color: Colors.teal, fontSize: 15.0))),
                        child: Container(
                          padding: EdgeInsets.all(40.0),
                          child: Column(
                            children: [
                              TextField(
                                autofocus: true,
                                controller: controller,
                                decoration: InputDecoration(labelText: "enter dice"),
                                keyboardType: TextInputType.emailAddress,
                              ),
                              TextField(
                                controller: controller2,
                                decoration: InputDecoration(labelText: "enter pw"),
                                keyboardType: TextInputType.text,
                                obscureText: true, //비번칠때 글자 안보이게
                              ),
                              SizedBox(
                                height: 40.0,
                              ),
                              ButtonTheme(
                                  minWidth: 100.0,
                                  height: 50.0,
                                  child: RaisedButton(
                                      color: Colors.orangeAccent,
                                      child: Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                        size: 35.0,
                                      ),
                                      onPressed: () {
                                        if (controller.text == 'dice' && controller2.text == '1234'){
                                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Dice() ));
                                        }else if(controller.text == 'dice' && controller2.text != '1234'){
                                          showSnackBar(context,'비번 정보를 다시확인하세요');
                                        }else if(controller.text != 'dice' && controller2.text == '1234'){
                                          showSnackBar(context,'아이디 정보를 다시확인하세요');
                                        }else{
                                          showSnackBar(context,'로그인 정보를 다시확인하세요');
                                        }
                                      }
                                  )
                              )
                            ],
                          ),
                        ),
                      ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

showSnackBar(BuildContext context, String text){
  Scaffold.of(context).showSnackBar(SnackBar(content: Text(text,
  textAlign: TextAlign.center,),
  duration: Duration(seconds: 2),
  backgroundColor: Colors.blue,));
}

