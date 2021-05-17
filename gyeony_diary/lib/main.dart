import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:gyeony_diary/repo/main_repo.dart';
import 'package:gyeony_diary/screen/main_screen.dart';
import 'package:gyeony_diary/screen/post_screen.dart';

import 'bloc/main_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => BlocProvider(
            create: (_) => MainBloc(MainRepo()),
            child: MainScreen())),
        GetPage(name: '/post', page: () => BlocProvider(
            create: (_) => MainBloc(MainRepo()),
            child: PostScreen())),      ],
    );
  }
}
