import 'package:bloc_music/bloc/main_bloc.dart';
import 'package:bloc_music/widget/music_list.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('music steaming'),
      ),
      body: BlocProvider(
        create: (_) => MainBloc(httpClient: http.Client())..add(GetMusicList()),
        child: MusicList(),
      ),
    );
  }
}


