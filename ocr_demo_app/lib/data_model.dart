import 'package:equatable/equatable.dart';
part 'data_model.g.dart';

class DataModel extends Equatable {
  final String version; //사업자명 또는 성함
  final String requestId; //연락처
  final int timestamp; //상담가능 시
  final List<ImageModel> images; //상담내용


  const DataModel({
    this.version,
    this.requestId,
    this.timestamp,
    this.images,

  });

  factory DataModel.fromJson(Map<String, dynamic> json) =>
      _$DataModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataModelToJson(this);

  @override
  List<Object> get props => [version, requestId, timestamp, images];
}

class ImageModel extends Equatable{
  final String format;
  final String data;
  final String name;

  const ImageModel({
    this.format,
    this.data,
    this.name,
  });
  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      _$ImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImageModelToJson(this);

  @override
  List<Object> get props => [format, data, name];
}
