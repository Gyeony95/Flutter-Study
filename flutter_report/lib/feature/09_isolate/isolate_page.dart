import 'dart:io';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_report/feature/main_frame.dart';
import 'package:flutter_report/main.dart';

void sleepApp(SendPort sendPort) {
  sleep(const Duration(seconds: 5));
  sendPort.send("isolate over!");
}


class IsolatePage extends StatefulWidget {
  const IsolatePage({Key? key}) : super(key: key);

  @override
  State<IsolatePage> createState() => _IsolatePageState();
}

class _IsolatePageState extends State<IsolatePage> {

  String? loadedData;
  late Isolate _isolate;
  final _receivePort = ReceivePort();

  @override
  void initState() {
    super.initState();
    _receivePort.listen((message) {
      setState(() {
        loadedData = message.toString();
      });
    });
  }

  @override
  void dispose() {
    _receivePort.close();
    _isolate.kill(priority: Isolate.immediate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainFrame(
      route: FeatureEnum.isolate,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Builder(builder: (_) {
            if(loadedData == null){
              return const SizedBox();
            }
            if(loadedData!.isEmpty){
              return const CircularProgressIndicator();
            }
            return Text(loadedData!);
          },),
          const SizedBox(height: 10,),
          ElevatedButton(onPressed: onTapMethodCall, child: const Text('Call Method')),
          const SizedBox(height: 10,),
          ElevatedButton(onPressed: onTapMethodCallWithIsolate, child: const Text('Call Method With Isolate')),
          const SizedBox(height: 10,),
          ElevatedButton(onPressed: onTapCancelIsolate, child: const Text('Cancel Isolate')),
        ],
      ),
    );
  }

  /// 아이솔레이트 없이 sleep을 호출함 -> 화면 멈춤
  Future<void> onTapMethodCall() async {
    setState(() {
      loadedData = '';
    });
    sleep(const Duration(milliseconds: 5000));
    setState(() {
      loadedData = 'just sleep over';
    });
  }

  /// 아이솔레이트를 통해 별도 메모리를 할당시켜 UI에 영향을 주지 않고 로직 실행
  Future<void> onTapMethodCallWithIsolate() async {
    setState(() {
      loadedData = '';
    });

    _isolate = await Isolate.spawn<SendPort>(
        sleepApp, _receivePort.sendPort);
  }

  /// 작업 중단
  void onTapCancelIsolate(){
    _isolate.kill(priority: Isolate.immediate);

    setState(() {
      loadedData = 'Task canceled';
    });
  }
}
