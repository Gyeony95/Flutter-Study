import 'dart:async';
import 'dart:developer';
import 'package:gyeony_diary/model/meno_model.dart';
import 'package:gyeony_diary/model/post_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String tableName = 'post';
final String columnId = 'id';
final String columnTime = 'time';
final String columnContent = 'content';
final String columnImageUrl = 'imageUrl';

class PostProvider {
  Database _database;

  Future<Database> get database async {
    if(_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    String path = join(await getDatabasesPath(), 'study.db');

    return await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
          CREATE TABLE $tableName(
            $columnId integer primary key autoincrement, 
            $columnTime text not null,
            $columnContent text not null,
            $columnImageUrl text not null
          )
        ''');
        },
        onUpgrade: (db, oldVersion, newVersion){}
    );
  }

  Future<PostModel> insert(PostModel postModel) async {
    final db = await database;
    print(postModel.toMap());
    postModel.id = await db.insert(tableName, postModel.toMap());
    return postModel;
  }

  Future<void> delete(int id) async {
    final db = await database;
    print('ghghgh' + id.toString());
    await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
    // await db.delete(tableName, where: 'content = ?', whereArgs: ['1']);

  }

  Future<List<PostModel>> getPostList() async {
    final db = await database;
    List<Map> maps = await db.query(tableName,
        columns: [columnId, columnTime, columnContent, columnImageUrl],
        // where: '$columnId = ?',
        // whereArgs: [id]
    );

    List<PostModel> resultList = [];
    if (maps.length > 0) {
      var mList = maps.map((e) {
        resultList.add(PostModel.fromMap(e));
      });
      log('GHGHGH PostProvider.getPostList() ' + mList.toString());
      return resultList;
    }
    return null;
  }
}