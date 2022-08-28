import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_report/main.dart';

class AnimationExample extends StatefulWidget{
  const AnimationExample({Key? key}) : super(key: key);

  @override
  State<AnimationExample> createState() => _AnimationExampleState();
}

class _AnimationExampleState extends State<AnimationExample>
    with TickerProviderStateMixin{

  bool isRun = false;

  // 상단 컨테이너 애니메이션
  late AnimationController controller;
  late Animation<Offset> topAnimation;

  // 가운데 컨테이너 애니메이션
  late Animation<Offset> middleAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    topAnimation = Tween<Offset>(begin: const Offset(0,0), end: const Offset(0,-1))
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeInCubic));

    middleAnimation = Tween<Offset>(begin: const Offset(0,0), end: const Offset(1,0))
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeInCubic));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(FeatureEnum.animationExample.name),),
      body: Stack(
        children: [
          Column(
            children: [
              topContainer(),
              middleContainer(),
              bottomContainer(),
            ],
          ),
          Positioned(
            bottom: 50,
            right: 20,
            child: runButton())
        ],
      ),
    );
  }

  Widget topContainer(){
    return SlideTransition(
      position: topAnimation,
      child: Container(
        height: 150,
        decoration: const BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(40),)
        ),
      ),
    );
  }

  Widget middleContainer(){
    return SlideTransition(
      position: middleAnimation,
      child: Container(
        margin: const EdgeInsets.only(top: 20, left: 10),
        height: 100,
        child: ListView.builder(
          itemCount: 10,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Container(
            width: 100,
            height: 100,
            color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
          ),
        ),
      ),
    );
  }

  Widget bottomContainer(){
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
          itemBuilder: (context,index) {
            Animation<double> itemAnimation;
            itemAnimation = Tween<double>(begin: 1, end: 0)
                .animate(CurvedAnimation(parent: controller, curve: Interval(0.1 * index, 0.2 + index * 0.1)));
            return FadeTransition(
              opacity: itemAnimation,
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: const SizedBox(
                  width: double.infinity,
                  height: 70,
                ),
              ),
            );
          },
      ),
    );
  }

  Widget runButton(){
    return GestureDetector(
      onTap: (){
        if(isRun){
          controller.reverse();
        }else{
          controller.forward();
        }
        isRun = !isRun;
      },
      child: Container(
        width: 100,
        height: 50,
        color: Colors.amberAccent,
        alignment: Alignment.center,
        child: const Text('RUN!!', style: TextStyle(fontSize: 20),),
      ),
    );
  }
}
