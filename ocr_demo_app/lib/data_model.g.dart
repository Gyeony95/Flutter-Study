part of 'data_model.dart';
DataModel _$DataModelFromJson(Map<String, dynamic> json) {
  return DataModel(
    version: json['version'] as String,
    requestId: json['requestId'] as String,
    timestamp: json['timestamp'] as int,
    images: (json['images'] as List)
        ?.map((e) =>
    e == null ? null : ImageModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DataModelToJson(DataModel instance) =>
    <String, dynamic>{
      'version': instance.version,
      'requestId': instance.requestId,
      'timestamp': instance.timestamp,
      'images': instance.images,
    };

ImageModel _$ImageModelFromJson(Map<String, dynamic> json) {
  return ImageModel(
    format: json['format'] as String,
    data: json['data'] as String,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$ImageModelToJson(ImageModel instance) =>
    <String, dynamic>{
      'format': instance.format,
      'data': instance.data,
      'name': instance.name,
    };