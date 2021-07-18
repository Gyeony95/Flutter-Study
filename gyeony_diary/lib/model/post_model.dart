import 'package:flutter/material.dart';
import 'package:gyeony_diary/provider/post_provider.dart';

class PostModel{
  PostModel({this.id, this.time, this.content, this.imageUrl, this.isOpened});
  int id;
  String time;
  String content;
  String imageUrl;
  bool isOpened;

  PostModel copyWith({
    int id,
    String time,
    String content,
    String imageUrl,
    bool isOpened
  }) =>PostModel(
    id : id ?? this.id,
    time: time ?? this.time,
    content: content ?? this.content,
    imageUrl: imageUrl ?? this.imageUrl,
    isOpened: isOpened ?? this.isOpened,
  );

  @override
  String toString() => '''$PostModel {
    id : $id,
    time: $time,
    content: $content,
    imageUrl: $imageUrl,
    isOpened: $isOpened,
  }''';

  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
      columnId : id,
      columnTime : time,
      columnContent : content,
      columnImageUrl : imageUrl,
    };
    return map;
  }

  PostModel.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    time = map[columnTime];
    content = map[columnContent];
    imageUrl = map[columnImageUrl];
    print('$id, $time, $content, $imageUrl');
  }


}