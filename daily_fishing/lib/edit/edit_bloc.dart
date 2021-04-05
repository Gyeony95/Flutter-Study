
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
    if (event is UpdateImage) {
      //yield await _mapPostFetchedToState(state);
    }
  }

}