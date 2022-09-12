import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:donforget/models/task.dart';


class DBHelper {


  static Database? _dp;
  static const int _version=1;
  static const String _table_name='task';

  static Future<void>initDb()async{

    if(_dp !=null){
      debugPrint('db not nulllll');
      return;
    }

      try{
        String _path =await getDatabasesPath()+'task.dp';
        debugPrint('in db path');
        _dp=await openDatabase(_path,version: _version,onCreate: (Database db, int version)async{

          await db.execute('CREATE TABLE $_table_name ('
              'id INTEGER PRIMARY KEY AUTOINCREMENT,'
              'title STRING ,'
              'note TEXT,'
              'isCompleted INTEGER,'
              'date STRING,'
              'startTime STRING,'
              'endTime STRING,'
              'color INTEGER,'
              'remind STRING,'
              'repeat String'
              ')' );

        });

      }catch(e){
        print(e);

    }
  }

  static Future<int>insert(Task? task)async{
    print('insert to databaseeee');

    return await _dp!.insert(_table_name, task!.toJson(task));
  }

  static Future<int>delete(Task task)async{
    print('delete from databaseeee');

    return await _dp!.delete(_table_name, where: 'id = ?',whereArgs: [task.id]);
  }

  static Future<int>deleteAll()async{
    print('delete all from databaseeee');

    return await _dp!.delete(_table_name);
  }

  static Future<int>Update(Task task)async{
    print('update databaseeeee');


    /// noteee follow this quotations  in each raw update query
    return await _dp!.rawUpdate('''
      UPDATE $_table_name
          SET isCompleted = ?
          WHERE id = ?
          ''' ,[1,task.id]
    );
  }

  static Future<List<Map<String, dynamic>>>query()async{
    print('qqqqquerry');

    return await _dp!.query(_table_name);
  }
}
