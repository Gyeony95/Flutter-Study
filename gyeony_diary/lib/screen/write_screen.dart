import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gyeony_diary/bloc/write/write_bloc.dart';
import 'package:gyeony_diary/bloc/write/write_event.dart';
import 'package:gyeony_diary/bloc/write/write_state.dart';
import 'package:gyeony_diary/widget/flare_progress.dart';

class WriteScreen extends StatefulWidget {
  @override
  _WriteScreenState createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {


  TextEditingController _contentTextEditingController;
  WriteBloc _writeBloc;

  @override
  void initState() {
    super.initState();
    _writeBloc = context.read<WriteBloc>();

    _contentTextEditingController = TextEditingController()
      ..addListener(() {
        _writeBloc.add(ChangeContentText(content: _contentTextEditingController.text));
        log( _contentTextEditingController.text);
      });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: const Color(0xff867ae9),
      ),
      body: BlocConsumer<WriteBloc, WriteState>(
        listener: (context, state){

        },
        builder: (context, state){
          if(state is WriteLoading){
            return Center(child: FlareProgress(),);
          }
          if(state is WriteLoaded){
            return Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text('사진 추가하기')
                  ),

                  Row(
                    children: [
                      Container(
                          child: Icon(Icons.add,),
                      ),


                    ],
                  ),

                  Container(
                    child: Container(
                      height: 3 * 24.0,
                      child: TextField(
                        controller: _contentTextEditingController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter a message",
                          // fillColor: Colors.grey[300],
                          filled: true,
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
