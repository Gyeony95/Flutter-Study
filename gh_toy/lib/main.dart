import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gh_toy/login/login_screen.dart';
import 'package:gh_toy/post/post_bloc.dart';
import 'package:gh_toy/post/post_screen.dart';

import 'maintab/main_tab_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: LoginScreen.routeName,
      routes: {
        LoginScreen.routeName:(context)=> LoginScreen(),
        PostScreen.routeName:(context)=> MultiBlocProvider(
          providers: [
          BlocProvider(create: (_)=> PostBloc()),
          BlocProvider(create: (_) => MainTabBloc(),
          ),
        ], child: PostScreen(),),
      },
    );
  }
}