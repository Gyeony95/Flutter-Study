import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:ocr_demo_app/permission_manager.dart';
import 'package:ocr_demo_app/data_model.dart';
import 'package:permission_handler/permission_handler.dart';


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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  var api_url = 'https://5f1f45080b7a4bc9b0d346e334fadde5.apigw.ntruss.com/custom/v1/9490/a509203108dc6c4c3388709dc5002103efe4e849d02e3c2d4a2645b86a385af1/document/id-card';
  var secret_key = 'YVFIRlRyeWFmWVhjbmRNYVFoR0dVVkVXdVdLbFRsWVQ=';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            RaisedButton(onPressed: () async {
              if (Platform.isAndroid
                  ? await PermissionManager()
                      .checkPermission(Permission.storage)
                  : await PermissionManager()
                      .checkPermission(Permission.photos)) {
                final images = await MultiImagePicker.pickImages(
                  maxImages: 10,
                );

                if (images?.isNotEmpty == true) {
                  // final list = <File>[];
                  images.forEach(
                    (image) async {
                      final file = File(
                        await FlutterAbsolutePath.getAbsolutePath(
                          image.identifier,
                        ),
                      );
                      // list.add(file);

                      // log('name '+image.name);
                      // log('identifier '+image.identifier);
                      // log('isLandscape '+image.isLandscape.toString());
                      // log('isPortrait '+image.isPortrait.toString());
                      // log('metadata '+image.metadata.toString());
                      // log('toString '+image.toString());
                      // var test = image.metadata.then((value) => log('metadata future '+value.toString()));
                      final list = <ImageModel>[];
                      final bytes = file.readAsBytesSync();
                      String base64Encode(List<int> bytes) => base64.encode(bytes);
                      var mmm = image.name.split('.');


                      // list.add(ImageModel(
                      //   format: mmm[mmm.length-1],
                      //   // data: base64Encode(bytes),
                      //   name: mmm[0],
                      // ));
                      // var dModel = DataModel(
                      //   version: 'V2',
                      //   requestId: '123456asdasd',
                      //   timestamp: 3000,
                      //   images:list
                      // );

                      // log('ghghgh dModel.toJson()  '+dModel.toJson().toString());

                      // var request_json = {
                      //   'images' : [
                      //     {
                      //       'format': 'jpg',
                      //       'name': 'Screenshot_20210621-132525',
                      //       'data' : base64Encode,
                      //     }
                      //   ],
                      //   'requestId': 'ddds5s5d5d5',
                      //   'version': 'V2',
                      //   'timestamp': 1584062336793
                      // };

                      var request_json = {
                        'images' : [
                          {
                            'format': 'jpg',
                            'name': 'Screenshot_20210621-132525',
                            'data' : base64Encode,
                          }
                        ],
                        'requestId': 'ddds5s5d5d5',
                        'version': 'V2',
                        'timestamp': 1584062336793
                      };


                      // var formData = FormData.fromMap({
                      //   // 'message':json.encode(request_json),
                      //   'message':request_json,
                      //   'file':file,
                      // });
                      //
                      //
                      // var response1 = await Dio().post(
                      //     api_url,
                      //     data: formData,
                      //     options: Options(headers: {
                      //       'X-OCR-SECRET':secret_key,
                      //       // 'Content-Type':'multipart/form-data',
                      //     }
                      //     )
                      // );
                      // print('ghghgh res '+response1.toString());

                      // var image_json =  [
                      //   {
                      //     'format': 'jpg',
                      //     'name': 'Screenshot_20210621-132525',
                      //     'data' : base64Encode,
                      //   }
                      // ];


                      var hashMap = {
                        'message': request_json,
                        'file' : file,
                      };

                      var response2 = await http.post(
                        Uri.parse(api_url),
                        headers:  {
                          'X-OCR-SECRET':secret_key,
                        },
                        body:  hashMap.toString(),
                      );

                      log('ghghgh response  '+response2.body.toString());

                      // if (list.length == images.length) {
                      //   _chatBloc.add(
                      //   UploadFile(files: list),
                      //   );
                      // }
                    },
                  );
                }
              }
            })
          ],
        ),
      ),
    );
  }
}
