
import 'dart:html';
import 'dart:typed_data';
import 'package:daily_fishing/edit/edit_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'edit_bloc.dart';
import 'edit_state.dart';

class EditScreen extends StatefulWidget {
  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  EditBloc _editBloc;

  @override
  void initState() {
    super.initState();
    _editBloc = context.read<EditBloc>();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('edit screen'),
      ),
      body: BlocBuilder<EditBloc, EditState>(
        builder: (context, state){
          if(state.status == EditStatus.initial){
            return Center(
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('새로운 기사 만들기', style: TextStyle(
                        fontSize: 30,
                      )),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 2,
                        color: Colors.black26,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('기사 제목, 내용 요약, 이미지는 카카오톡이나 페이스북에 공유했을때 나오게 됩니다.'),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: new InputDecoration(
                          hintText: 'ex) 충격! 연예인 A모씨 일반인과 열애중!',
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: new InputDecoration(
                          hintText: 'ex) 소속사에서는 3개월째 뜨거운 열애를 하고 있다고 밝혔다.',
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.black,
                          ),
                        ),
                        child: InkResponse(
                          child: MaterialButton(
                            onPressed: (){
                              _editBloc.add(FilePick());
                            },
                            child: Container(
                                padding: EdgeInsets.all(10),
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Center(child: Text('이미지 업로드'))),
                          ),
                        ),
                      ),
                    ],
                  )
              ),
            );
          }else if(state.status == EditStatus.success){
            return Center(
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('새로운 기사 만들기', style: TextStyle(
                        fontSize: 30,
                      )),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 2,
                        color: Colors.black26,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('기사 제목, 내용 요약, 이미지는 카카오톡이나 페이스북에 공유했을때 나오게 됩니다.'),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: new InputDecoration(
                          hintText: 'ex) 충격! 연예인 A모씨 일반인과 열애중!',
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: new InputDecoration(
                          hintText: 'ex) 소속사에서는 3개월째 뜨거운 열애를 하고 있다고 밝혔다.',
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.black,
                          ),
                        ),
                        child: InkResponse(
                          child: MaterialButton(
                            onPressed: (){},
                            child: Container(
                                padding: EdgeInsets.all(10),
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Center(child: Text('이미지 업로드'))),
                          ),
                        ),
                      ),
                      // Image(
                      //   image: AssetImage('assets/flutter_logo.png'),
                      // ),
                      Container(

                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 500,
                        // child: Image.network(
                        //   'https://picsum.photos/250?image=9',
                        //   width: MediaQuery.of(context).size.width * 0.3,
                        // ),
                        child: Image.memory(state.filePath),
                      )
                    ],
                  )
              ),
            );
          }
          return Text('is error');
        }

      )
    );
  }


}
