import 'package:equatable/equatable.dart';
part 'data_model.g.dart';

class DataModel extends Equatable {
  final String version;
  final String requestId;
  final int timestamp;
  final List<ImagesModel> images;


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
//------------------------------------------------------------------------------------------------------------------------

class ImagesModel extends Equatable{
  final Map<String,dynamic> idCard;
  final List<dynamic> boundingPolys;

  const ImagesModel({
    this.idCard,
    this.boundingPolys,
  });
  factory ImagesModel.fromJson(Map<String, dynamic> json) =>
      _$ImagesModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImagesModelToJson(this);

  @override
  List<Object> get props => [idCard, boundingPolys];
}

//------------------------------------------------------------------------------------------------------------------------


class IdCardModel extends Equatable{
  final bool isConfident;
  final Map<String, dynamic> dlData;

  const IdCardModel({
    this.isConfident,
    this.dlData,
  });
  factory IdCardModel.fromJson(Map<String, dynamic> json) =>
      _$IdCardModelFromJson(json);

  Map<String, dynamic> toJson() => _$IdCardModelToJson(this);

  @override
  List<Object> get props => [isConfident, dlData];
}
//
// //------------------------------------------------------------------------------------------------------------------------
//
// class DlDataModel extends Equatable{
//   final List<TypeListModel> type;
//   final List<NumListModel> num;
//   final List<NameListModel> name;
//   final List<PersonalNumListModel> personalNum;
//   //adress 안받음
//
//   const DlDataModel({
//     this.type,
//     this.num,
//     this.name,
//     this.personalNum,
//   });
//   factory DlDataModel.fromJson(Map<String, dynamic> json) =>
//       _$DlDataModelFromJson(json);
//
//   Map<String, dynamic> toJson() => _$DlDataModelToJson(this);
//
//   @override
//   List<Object> get props => [type, num, name, personalNum];
// }
// //------------------------------------------------------------------------------------------------------------------------
//
//
// class TypeListModel extends Equatable{
//   final String text;
//   final List<BndpolysModel> boundingPolys;
//
//   const TypeListModel({
//     this.text,
//     this.boundingPolys,
//   });
//   factory TypeListModel.fromJson(Map<String, dynamic> json) =>
//       _$TypeListModelFromJson(json);
//
//   Map<String, dynamic> toJson() => _$TypeListModelToJson(this);
//
//   @override
//   List<Object> get props => [text, boundingPolys];
// }
// //------------------------------------------------------------------------------------------------------------------------
