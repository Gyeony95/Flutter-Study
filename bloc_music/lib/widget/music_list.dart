import 'package:bloc_music/bloc/main_bloc.dart';
import 'package:bloc_music/widget/shadowed_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MusicList extends StatefulWidget {
  @override
  _MusicListState createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  final _scrollController = ScrollController();
  MainBloc _mainBloc;

  @override
  void initState(){
    super.initState();
    _scrollController.addListener(_onScroll);
    _mainBloc = context.read<MainBloc>();
    _mainBloc.add(GetMusicList());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<MainBloc, MainState>(
        builder: (context, state){
          return ListView.separated(
              itemBuilder:(context, index) {
                final item = state.lists[index];
                return ShadowedCard(
                  margin: EdgeInsets.all(10.0),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: <Widget>[
                        Image.network(item.imgUrl, width: 50, height: 50,),
                        SizedBox(width: 20.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '${item.title}',
                                style: TextStyle(fontSize: 16.0),
                                overflow: TextOverflow.fade,
                                maxLines: 1,
                                softWrap: false,
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () {},
                );
              },
              separatorBuilder: (context, index) =>
                  SizedBox(height: 20.0),
              itemCount:  state.lists?.length ?? 0
          );
        },
      ),
    );
  }

  _onScroll(){

  }
}
