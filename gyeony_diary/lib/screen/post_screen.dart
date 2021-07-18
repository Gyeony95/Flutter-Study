import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:gyeony_diary/bloc/post/post_bloc.dart';
import 'package:gyeony_diary/bloc/post/post_event.dart';
import 'package:gyeony_diary/bloc/post/post_state.dart';
import 'package:gyeony_diary/screen/post_widget.dart';
import 'package:gyeony_diary/widget/flare_progress.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  PostBloc _postBloc;

  @override
  void initState() {
    super.initState();
    _postBloc = context.read<PostBloc>();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(''),
          backgroundColor: const Color(0xff867ae9),
        ),
        body: BlocConsumer<PostBloc, PostState>(
          listener: (context, state){
            
          },
          builder: (context, state){
            if(state is PostLoading){
              return Center(child: FlareProgress());
            }
            if(state is PostLoaded){
              return Container(
                child: Column(
                  children: [
                    InkResponse(
                      onTap: (){
                        //여기에 일기쓰는 화면으로 이동 추가
                        Get.toNamed('/write');
                      },
                      child: Container(
                        margin: EdgeInsets.all(20),
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 0.5),
                        ),
                        child: Center(child: Text('오늘 일기 추가하기!')),
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                          // shrinkWrap: true, // use this
                          separatorBuilder: (context, index) => Divider(
                            height: 1.0,
                            thickness: 1.0,
                            color: Color(0xffe4e4e4),
                          ),
                          itemCount: state.list.length,
                          itemBuilder: (context, index) {
                            if (index >= state.list.length) {
                              return Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(vertical: 20.0),
                                child: const FlareProgress(),
                              );
                            }
                            return PostItem(model: state.list[index]
                              , openPressed:() =>_postBloc.add(SwitchItemState(index: index))
                              , menuPressed:() => showCupertinoModalPopup(
                                context: context,
                                builder: (context) => CupertinoActionSheet(
                                  actions: <Widget>[
                                    CupertinoActionSheetAction(
                                      child:
                                      Text('삭제',),
                                      onPressed: () {

                                      },
                                    ),
                                    CupertinoActionSheetAction(
                                      child:Text('삭제', style: TextStyle(color: Colors.red),),
                                      onPressed: () {
                                      },
                                    ),
                                  ],
                                  cancelButton: CupertinoActionSheetAction(
                                    isDestructiveAction: true,
                                    child: Text('취소'),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ),
                              ),
                            );
                          }
                      ),
                    )
                  ],
                ),
              );
            }
            return Center();
          },
        ));
  }
}

