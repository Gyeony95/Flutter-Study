import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:gyeony_diary/bloc/main_event.dart';
import 'package:gyeony_diary/repo/detail_repo.dart';
import 'package:gyeony_diary/repo/main_repo.dart';
import 'package:gyeony_diary/repo/post_repo.dart';
import 'package:gyeony_diary/screen/detail_screen.dart';
import 'package:gyeony_diary/screen/main_screen.dart';
import 'package:gyeony_diary/screen/post_screen.dart';

import 'bloc/detail_bloc.dart';
import 'bloc/detail_event.dart';
import 'bloc/main_bloc.dart';
import 'bloc/post_bloc.dart';
import 'bloc/post_event.dart';

// Create a Focus Intent that does nothing
class FakeFocusIntent extends Intent {
  const FakeFocusIntent();
}

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
      shortcuts: Map<LogicalKeySet, Intent>.from(WidgetsApp.defaultShortcuts)
        ..addAll(<LogicalKeySet, Intent>{
          LogicalKeySet(LogicalKeyboardKey.arrowLeft): const FakeFocusIntent(),
          LogicalKeySet(LogicalKeyboardKey.arrowRight): const FakeFocusIntent(),
          LogicalKeySet(LogicalKeyboardKey.arrowDown): const FakeFocusIntent(),
          LogicalKeySet(LogicalKeyboardKey.arrowUp): const FakeFocusIntent(),
        }),
      debugShowCheckedModeBanner: false,      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => BlocProvider(
            create: (_) => MainBloc(MainRepo())..add(GetDailyDiaryData()),
            child: MainScreen())),
        GetPage(name: '/post', page: () => BlocProvider(
            create: (_) => PostBloc(PostRepo())..add(GetDiaryList()),
            child: PostScreen())),
        GetPage(name: '/detail', page: () => BlocProvider(
            create: (_) => DetailBloc(DetailRepo())..add(testtest()),
            child: DetailScreen())),
        //GetPage(name: '/fullPage', page: FullPageEditorScreen())

      ],

    );
  }

}
