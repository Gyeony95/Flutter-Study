import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gyeony_diary/bloc/write/write_bloc.dart';
import 'package:gyeony_diary/bloc/write/write_event.dart';
import 'package:gyeony_diary/bloc/write/write_state.dart';
import 'package:gyeony_diary/model/post_model.dart';
import 'package:gyeony_diary/provider/main_provider.dart';
import 'package:gyeony_diary/provider/post_provider.dart';
import 'package:gyeony_diary/util/permission_manager.dart';
import 'package:gyeony_diary/widget/common_button.dart';
import 'package:gyeony_diary/widget/flare_progress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class WriteScreen extends StatefulWidget {
  @override
  _WriteScreenState createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {


  TextEditingController _contentTextEditingController;
  WriteBloc _writeBloc;

  @override
  void initState() {
    super.initState();
    _writeBloc = context.read<WriteBloc>();

    _contentTextEditingController = TextEditingController()
      ..addListener(() {
        _writeBloc.add(ChangeContentText(content: _contentTextEditingController.text));
        log( _contentTextEditingController.text);
      });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: const Color(0xff867ae9),
      ),
      body: BlocConsumer<WriteBloc, WriteState>(
        listener: (context, state){

        },
        builder: (context, state){
          if(state is WriteLoading){
            return Center(child: FlareProgress(),);
          }
          if(state is WriteLoaded){
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [

                    if(state.imagePath != null)
                      Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: Image.file(File(state.imagePath))),


                    Container(
                        width: MediaQuery.of(context).size.width,
                        child: Text('사진 추가하기')
                    ),

                    Row(
                      children: [
                        InkWell(
                          onTap: ()=>showCupertinoModalPopup(
                            context: context,
                            builder: (context) => CupertinoActionSheet(
                              actions: [
                                CupertinoActionSheetAction(onPressed: () async{
                                  Navigator.pop(context);
                                  if (await PermissionManager()
                                      .checkPermission(Permission.camera)){
                                    final image = await ImagePicker().getImage(
                                      source: ImageSource.camera,
                                    );
                                    if (image != null) {
                                      _writeBloc.add(ChangeImagePath(path: image.path));

                                    }
                                  }

                                }, child: Text(
                                  '사진촬영',
                                  style: TextStyle(
                                    color: const Color(0xff007aff),
                                  ),
                                )),
                                CupertinoActionSheetAction(onPressed: ()async{
                                  if(Platform.isAndroid ? await PermissionManager().checkPermission(Permission.storage)
                                      : await PermissionManager().checkPermission(Permission.photos)){
                                    final images = await MultiImagePicker.pickImages(
                                      maxImages: 10,
                                    );

                                    if (images?.isNotEmpty == true) {
                                      final list = <File>[];
                                      images.forEach(
                                            (image) async {
                                          final file = File(
                                            await FlutterAbsolutePath.getAbsolutePath(
                                              image.identifier,
                                            ),
                                          );
                                          list.add(file);

                                          if (list.length == images.length) {
                                            // _chatBloc.add(
                                            //   UploadFile(files: list),
                                            // );
                                          }
                                        },
                                      );
                                    }
                                  }
                                }, child: Text(
                                  '앨범',
                                  style: TextStyle(
                                    color: const Color(0xff007aff),
                                  ),
                                )),
                              ],
                              cancelButton: CupertinoActionSheetAction(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  '취소',
                                  style: TextStyle(
                                    color: const Color(0xff007aff),
                                  ),
                                ),
                              ),
                            )
                          ),
                          child: Container(
                              child: Icon(Icons.add,),
                          ),
                        ),


                      ],
                    ),

                    Container(
                      child: Container(
                        height: 3 * 24.0,
                        child: TextField(
                          controller: _contentTextEditingController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter a message",
                            // fillColor: Colors.grey[300],
                            filled: true,
                          ),
                        ),
                      ),
                    ),
                    CommonButton(onPressed: (){
                      _insertDB();
                    }, text: '완료')

                  ],
                ),
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
  Future<void> _insertDB() async {
    var provider = PostProvider();
    var post = PostModel(content: _contentTextEditingController.text, time: DateTime.now().toString(), imageUrl: _writeBloc.getImageUrl());
    provider.insert(post);
  }
}


