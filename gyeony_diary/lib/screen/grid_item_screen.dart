import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gyeony_diary/screen/detail_widget.dart';
import 'dart:ui' as ui;
import 'package:gyeony_diary/bloc/detail_bloc.dart';
import 'package:gyeony_diary/bloc/detail_state.dart';
import 'package:gyeony_diary/bloc/detail_event.dart';
import 'package:gyeony_diary/widget/flare_progress.dart';
class GridItemScreen extends StatefulWidget {
  @override
  _GridItemScreenState createState() => _GridItemScreenState();
}

class _GridItemScreenState extends State<GridItemScreen> {


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
                  return StaggeredGridView.countBuilder(
                    crossAxisCount: 4,
                    itemCount: state.list.length-1,
                    // itemBuilder: (BuildContext context, int index) => CustomTile(index, IntSize(20,40), state.list[index].imageUrl),
                    itemBuilder: (context, index) => Image.asset(state.list[index].imageUrl,fit: BoxFit.fill,),
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                    staggeredTileBuilder: (index) => const StaggeredTile.fit(2),

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

