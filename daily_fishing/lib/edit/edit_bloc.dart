
import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

import 'edit_event.dart';
import 'edit_state.dart';


class EditBloc extends Bloc<EditEvent, EditState>{
  EditBloc({this.httpClient}) : super(const EditState());

  final http.Client httpClient;



  @override
  Stream<EditState> mapEventToState(EditEvent event) async* {
    if (event is FilePick) {
      yield await _FilePick(state);
    }

    // if (event is UpdateImage) {
    //   yield await _UpdateImage(state);
    // }
  }


  Future<EditState>_FilePick(EditState state){
    InputElement uploadInput = FileUploadInputElement();
    uploadInput.click();
    print('1' + state.status.toString());

    print('1');
    print('1' + state.status.toString());
    uploadInput.onChange.listen((e) {
      print('2');

      // read file content as dataURL
      final files = uploadInput.files;
      if (files.length == 1) {
        final file = files[0];
        FileReader reader =  FileReader();
        print('3');

        reader.onLoadEnd.listen((e) {
          print('4');

          //add(UpdateImage(filePath: reader.result));
          state.copyWith(status: EditStatus.success, filePath: reader.result);
          print('5');

        });

        reader.onError.listen((fileEvent) {
          print('6');

          // setState(() {
          //   option1Text = "Some Error occured while reading the file";
          // });
        });
        reader.readAsArrayBuffer(file);
      }
    });
  }

  Future<EditState>_UpdateImage(EditState state){

  }

}