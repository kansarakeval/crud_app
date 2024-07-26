import 'dart:io';
import 'package:crud_app/screen/home/model/home_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static DbHelper dbHelper = DbHelper._();

  DbHelper._();

  Database? database;
  final String DB_NAME = "data.db";

  Future<Database> checkDB() async {
    if (database != null) {
      return database!;
    } else {
      return await initDB();
    }
  }

  Future<Database> initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, DB_NAME);
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String formTable =
            "CREATE TABLE form(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT , email TEXT, password TEXT, number Text)";
        db.execute(formTable);
      },
    );
  }

  //insertForm
  Future<void> insertFormData(HomeModel homeModel) async {
    database = await checkDB();
    database!.insert("form", {
      "name":homeModel.name,
      "email":homeModel.email,
      "password":homeModel.password,
      "number":homeModel.number

    });
  }

  //readForm
  Future<List<HomeModel>> readFormData() async {
    database = await checkDB();
    String query = "SELECT * FROM form";
    List<Map> data = await database!.rawQuery(query, null);
    List<HomeModel> modelList = data.map((e) => HomeModel.mapToModel(e)).toList();
    return modelList;
  }

  //deleteForm
  Future<void> deleteFormData({required int id}) async {
    database = await checkDB();
    database!.delete("form", where: "id=?", whereArgs: [id]);
  }

  Future<void> updateFormData(int id,HomeModel homeModel) async {
    database = await checkDB();
    database!.update("form", {
      "name":homeModel.name,
      "email":homeModel.email,
      "password":homeModel.password,
      "number":homeModel.number
    } ,where: "id=?",whereArgs: [id] );
  }
}
