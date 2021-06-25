import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import 'package:flutter/material.dart';


import 'bloc/main_bloc.dart';
import 'bloc/main_event.dart';
import 'camera_view.dart';
import 'main_repo.dart';
import 'main_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      // shortcuts: Map<LogicalKeySet, Intent>.from(WidgetsApp.defaultShortcuts)
      //   ..addAll(<LogicalKeySet, Intent>{
      //     LogicalKeySet(LogicalKeyboardKey.arrowLeft): const FakeFocusIntent(),
      //     LogicalKeySet(LogicalKeyboardKey.arrowRight): const FakeFocusIntent(),
      //     LogicalKeySet(LogicalKeyboardKey.arrowDown): const FakeFocusIntent(),
      //     LogicalKeySet(LogicalKeyboardKey.arrowUp): const FakeFocusIntent(),
      //   }),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => BlocProvider(
            create: (_) => MainBloc(MainRepo()),
            child: MainScreen())),
        GetPage(name: '/camera', page: () => CameraPreviewScreen()),

        //GetPage(name: '/fullPage', page: FullPageEditorScreen())

      ],

    );
  }
}
