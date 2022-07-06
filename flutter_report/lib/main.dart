import 'package:flutter/material.dart';
import 'package:flutter_report/pages/01_animation_example_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const FeatureList(),
        FeatureEnum.animationExample.route: (context) => const AnimationExample(),
      },

    );
  }
}

class FeatureList extends StatefulWidget {
  const FeatureList({Key? key}) : super(key: key);

  @override
  State<FeatureList> createState() => _FeatureListState();
}

class _FeatureListState extends State<FeatureList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('플러터 기능 리스트'),),
      body: SafeArea(
        child: ListView.builder(
          itemCount: FeatureEnum.values.length,
          itemBuilder : listItem,
        ),
      ),
    );
  }

  Widget listItem(BuildContext context, int index){
    var currentFeature = FeatureEnum.values[index];
    return GestureDetector(
      onTap: currentFeature.onTap(context),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: const BorderRadius.all(Radius.circular(10))
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        width: double.infinity,
        height: 70,
        alignment: Alignment.center,
        child: Text(currentFeature.name, style: const TextStyle(
          fontSize: 20,
        ),),
      ),
    );
  }
}


enum FeatureEnum{
  animationExample,
}

extension FeatureEnumExtention on FeatureEnum{
  VoidCallback onTap(BuildContext context) => (){Navigator.pushNamed(context, route);};
  String get route{
    switch(this){
      case FeatureEnum.animationExample :
        return '/animation_example';
    }
  }
  String get name{
    switch(this){
      case FeatureEnum.animationExample :
        return '애니메이션 예제';
    }
  }
}