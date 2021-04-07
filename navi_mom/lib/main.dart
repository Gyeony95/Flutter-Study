import 'package:flutter/material.dart';
import 'package:navi_mom/route/navigator_manager.dart';
import 'package:navi_mom/route/screen_route_transition.dart';
import 'package:navi_mom/splash/splash_screen.dart';

import 'login/login_screen.dart';
import 'route/not_found_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final _navigatorKey = NavigatorManager().navigatorKey;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: SplashScreen.routeName,
      routes: {

      },
      //존재하지 않는 라우터 일때
      onUnknownRoute: (settings) {
        if(settings?.name?.isNotEmpty ?? false){
          if(settings.name.startsWith('http') || settings.name == '/link'){
            return null;
          }else{
            return MaterialPageRoute(
              builder: (context) => NotFoundScreen(settings.name),
            );
          }
        }else{
          return null;
        }
      },
      onGenerateRoute: (routeSettings) {
        switch (routeSettings.name) {
          case LoginScreen.routeName:
            return ScreenRouteTransition(
              settings: routeSettings,
              type: ScreenTransitionType.fade,
                child: LoginScreen()
            );

            // return ScreenRouteTransition(
            //   settings: routeSettings,
            //   type: ScreenTransitionType.fade,
            //   child: BlocProvider(
            //     create: (_) => LoginBloc(
            //       authenticationBloc: _authBloc,
            //       userRepository: UserRepository(
            //         userDataProvider: UserDataProvider(),
            //       ),
            //     ),
            //     child: LoginScreen(),
            //   ),
            // );
        }
        return null;
      },
      navigatorKey: _navigatorKey,

    );
  }
}
