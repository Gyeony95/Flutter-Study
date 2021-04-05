import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'edit/edit_bloc.dart';
import 'edit/edit_screen.dart';
import 'home/home_screen.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: HomePage(),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/welcome': (context) => BlocProvider(
            create: (_) => EditBloc(httpClient: http.Client()),
            child: EditScreen()
        ),
      },
    );
  }
}

