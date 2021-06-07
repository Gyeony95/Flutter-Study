import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gyeony_diary/bloc/post_bloc.dart';
import 'package:gyeony_diary/bloc/post_event.dart';
import 'package:gyeony_diary/bloc/post_state.dart';
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
              return Ink(
                color: const Color(0xfffdfaf6),
                child: ListView.separated(
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
                      return PostItem(model: state.list[index], openPressed:() =>_postBloc.add(SwitchItemState(index: index)));
                    }
                ),
              );
            }
            return Center();
          },
        ));
  }
}

