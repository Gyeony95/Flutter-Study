import 'package:gyeony_diary/provider/main_provider.dart';

class Memo {
  int id;
  String title;
  String content;

  Memo({this.id, this.title, this.content});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnTitle: title,
      columnContent: content,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  Memo.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    title = map[columnTitle];
    content = map[columnContent];
    print('$id, $title, $content');
  }
}