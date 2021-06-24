part of 'data_model.dart';
DataModel _$DataModelFromJson(Map<String, dynamic> json) {
  return DataModel(
    version: json['version'] as String,
    requestId: json['requestId'] as String,
    timestamp: json['timestamp'] as int,
    images: (json['images'] as List)
        ?.map((e) =>
    e == null ? null : ImagesModel.fromJson(e as Map<String, dynamic>))
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
//------------------------------------------------------------------------------------------------------------------------
ImagesModel _$ImagesModelFromJson(Map<String, dynamic> json) {
  return ImagesModel(
    idCard: (json['idCard'] as Map),
    //     ?.map((e) =>
    // e == null ? null : IdCardModel.fromJson(e as Map<String, dynamic>))
    //     ?.toList(),
    boundingPolys: (json['images'] as List)
    //     ?.map((e) =>
    // e == null ? null : BoundingPolys.fromJson(e as Map<String, dynamic>))
    //     ?.toList(),
  );
}

Map<String, dynamic> _$ImagesModelToJson(ImagesModel instance) =>
    <String, dynamic>{
      'idCard': instance.idCard,
      'boundingPolys': instance.boundingPolys,
    };

//
// //------------------------------------------------------------------------------------------------------------------------

IdCardModel _$IdCardModelFromJson(Map<String, dynamic> json) {
  return IdCardModel(
    isConfident: json['isConfident'] as bool,
    dlData: (json['dlData'] as Map)
    //     ?.map((e) =>
    // e == null ? null : DlDataModel.fromJson(e as Map<String, dynamic>))
    //     ?.toList(),
  );
}

Map<String, dynamic> _$IdCardModelToJson(IdCardModel instance) =>
    <String, dynamic>{
      'isConfident': instance.isConfident,
      'dlData': instance.dlData,
    };

// //------------------------------------------------------------------------------------------------------------------------
// DlDataModel _$DlDataModelFromJson(Map<String, dynamic> json) {
//   return DlDataModel(
//     type: (json['type'] as List)
//         ?.map((e) =>
//     e == null ? null : TypeListModel.fromJson(e as Map<String, dynamic>))
//         ?.toList(),
//     num: (json['num'] as List)
//         ?.map((e) =>
//     e == null ? null : NumListModel.fromJson(e as Map<String, dynamic>))
//         ?.toList(),
//     name: (json['name'] as List)
//         ?.map((e) =>
//     e == null ? null : NameListModel.fromJson(e as Map<String, dynamic>))
//         ?.toList(),
//     personalNum: (json['personalNum'] as List)
//         ?.map((e) =>
//     e == null ? null : PersonalNumListModel.fromJson(e as Map<String, dynamic>))
//         ?.toList(),
//   );
// }
//
// Map<String, dynamic> _$DlDataModelToJson(DlDataModel instance) =>
//     <String, dynamic>{
//       'type': instance.type,
//       'num': instance.num,
//       'name': instance.name,
//       'personalNum': instance.personalNum,
//     };
