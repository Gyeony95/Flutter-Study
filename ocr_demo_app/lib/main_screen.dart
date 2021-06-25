
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart' as path;
import 'dart:ui' as ui;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:ocr_demo_app/util/permission_manager.dart';
import 'package:ocr_demo_app/model/data_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http_parser/http_parser.dart';

import 'package:async/async.dart';

import 'bloc/main_bloc.dart';
import 'bloc/main_state.dart';
import 'bloc/main_event.dart';
import 'my_painter.dart';



class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}



class _MainScreenState extends State<MainScreen> {
  var api_url = 'https://5f1f45080b7a4bc9b0d346e334fadde5.apigw.ntruss.com/custom/v1/9490/a509203108dc6c4c3388709dc5002103efe4e849d02e3c2d4a2645b86a385af1/document/id-card';
  var secret_key = 'YVFIRlRyeWFmWVhjbmRNYVFoR0dVVkVXdVdLbFRsWVQ=';
  CameraController controller;

  MainBloc _mainBloc;

  @override
  void initState(){
    super.initState();
    _mainBloc = context.read<MainBloc>();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: BlocBuilder<MainBloc, MainState>(
        builder: (context, state){
          if(state is MainLoading){
            return Column(
              children: [
                Center(
                    child: RaisedButton(
                      child: Text('앨범'),
                      onPressed: () async {
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

                              var mData = await _loadImage(file);

                              var img = image.name.split('.');
                              var img_format = img[img.length-1];
                              var img_name = img[0];
                              //
                              // log(image.name);
                              // log(img_format);
                              // log(img_name);
                              final bytes = file.readAsBytesSync();
                              var request_json = {
                                'images' : [
                                  {
                                    'format': img_format,
                                    'name': img_name,
                                    'data' :bytes
                                  }
                                ],
                                'requestId': 'guide-demo',
                                'version': 'V2',
                                'timestamp': 1584062336793
                              };

                              // log('ghghgh form : '+request_json.toString());
                              try{
                                var response = await Dio(
                                    BaseOptions(
                                        headers: {
                                          'X-OCR-SECRET':secret_key,
                                          'Content-Type':'application/json',
                                        }
                                    )
                                ).post(
                                  api_url,
                                  data: request_json,
                                );

                                if (response.statusCode == HttpStatus.ok) {
                                  final data = DataModel.fromJson(response.data);
                                  // var type = data.images[0].idCard['result']['dl']['type'][0]['text'].toString()??'';
                                  var name = data.images[0].idCard['result']['dl']['num'][0]['text'].toString()??'';
                                  // var num = data.images[0].idCard['result']['dl']['name'][0]['text'].toString()??'';
                                  var personalNum = data.images[0].idCard['result']['dl']['personalNum'][0]['text'].toString()??'';
                                  var personalNum_ver = data.images[0].idCard['result']['dl']['personalNum'][0]['boundingPolys'][0].toString()??'';
                                  var personalNum_ver_xy = data.images[0].idCard['result']['dl']['personalNum'][0]['boundingPolys'][0]['vertices']??'';

                                  var ver_x = [];
                                  var ver_y = [];

                                  for(var i in personalNum_ver_xy){
                                    ver_x.add(i['x']);
                                    ver_y.add(i['y']);
                                  }
                                  ver_x.sort();
                                  ver_y.sort();

                                  final Rect rect  = Rect.fromPoints(Offset((ver_x[0]+ver_x[3])/2,ver_y[0]), Offset(ver_x[3],ver_y[3]));
                                  _mainBloc..add(GetImageData(image, file, mData,rect));

                                  // _mainBloc.add(SetRect(rect));
                                } else {
                                  throw '${response.statusMessage}';
                                }

                                log('ghghgh response '+response.data.toString());

                              }catch(e){
                                log('ghghgh err '+e.toString());
                              }
                            },
                          );
                        }
                      }
                    },
                    )),

                RaisedButton(
                    child: Text('카메라'),
                    onPressed: (){
                      Get.toNamed('/camera');

                    }),

              ],
            );
          }
          if(state is MainLoaded){

            log('ghghgh state :'+state.toString());
            return Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  // _file == null ? Text('No Image') : Image.file(_image, height: 300,fit: BoxFit.fill,),
                  // _file == null ? Text('No Image') : Image.file(_image),

                  ((state.uiImage == null)||(state.rect == null)) ? Text('No Image') :
                  // state.rect == null ? Text('No Image') :
                  Container(
                    height: 300,
                    child: FittedBox(
                      child: SizedBox(
                        width: state.uiImage.width.toDouble(),
                        height: state.uiImage.height.toDouble(),
                        child: CustomPaint(
                          painter: Sky(state.uiImage, state.rect),
                          child: Container(

                            child: CustomPaint(
                              painter: Sky(state.uiImage, state.rect),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            );
          }
          return Container();
        },

      ),
    );
  }

  Future<ui.Image> _loadImage(File file) async{
    final data = await file.readAsBytes();
    return await decodeImageFromList(data);
  }




}
