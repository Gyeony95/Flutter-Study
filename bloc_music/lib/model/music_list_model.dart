import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class MusicListModel extends Equatable{

  final String title;
  final String imgUrl;

  const MusicListModel({
    this.title,
    this.imgUrl,
  });

  @override
  List<Object> get props => [title, imgUrl];

}