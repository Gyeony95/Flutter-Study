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
    var viewWidth = MediaQuery.of(context).size.width;
    var viewHeight = MediaQuery.of(context).size.height;

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
                return StaggeredGridView.countBuilder(
                  crossAxisCount: 4,
                  itemCount: state.list.length-1,
                  // itemBuilder: (BuildContext context, int index) => CustomTile(index, IntSize(20,40), state.list[index].imageUrl),
                  itemBuilder: (context, index) => Image.asset(state.list[index].imageUrl,fit: BoxFit.fill,),
                  // staggeredTileBuilder: (int index) =>
                  //     StaggeredTile.count(2, 1),
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                  staggeredTileBuilder: (index) => const StaggeredTile.fit(2),

                );
              }

              return Container();
            },
          )
          // Stack(
          //   children: [
          //
          //     backdropFilter(context,ShadowedCard(
          //       child: Image.asset(
          //         'assets/images/default_image2.jpeg',
          //         height: viewHeight,
          //         //width: MediaQuery.of(context).size.width,ß
          //         //fit: BoxFit.none,
          //       ),
          //     ),)
          //   ],
          // ),
        ),
      ),
    );
  }
}

Widget backdropFilter(BuildContext context, Widget child) {
  return Stack(
    fit: StackFit.expand,
    children: <Widget>[
      child,
      BackdropFilter(
        filter: ui.ImageFilter.blur(
          sigmaX: 8.0,
          sigmaY: 8.0,
        ),
        child: Container(
          color: Colors.transparent,
        ),
      )
    ],
  );
}
