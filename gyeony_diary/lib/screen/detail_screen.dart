import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gyeony_diary/screen/detail_widget.dart';
import 'dart:ui' as ui;
import 'package:gyeony_diary/bloc/detail_bloc.dart';
import 'package:gyeony_diary/bloc/detail_state.dart';
import 'package:gyeony_diary/bloc/detail_event.dart';
import 'package:gyeony_diary/widget/flare_progress.dart';
class DetailScreen extends StatefulWidget {
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child:
          BlocBuilder<DetailBloc, DetailState>(
            builder: (context, state){
              if(state is DetailLoading){
                return Center(child: FlareProgress());
              }
              if(state is DetailLoaded){
                return Scaffold(
                  appBar: AppBar(
                    title: const Text(''),
                    backgroundColor: const Color(0xff867ae9),
                  ),
                  body: Container(),
                );
              }
              return Container();
            },
          )
        ),
      ),
    );
  }
}

