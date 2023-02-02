import 'package:acikliyorum/api/balance_control.dart';
import 'package:acikliyorum/models/database_model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DbHelper {
  static final DbHelper _dbHelper = DbHelper._internal();
  String tblTodo = "user";
  String colId = "id";
  String colTitle = "userid";


  DbHelper._internal();

  factory DbHelper() {
    return _dbHelper;
  }

  static Database? _db;
  Future<Database> get db async {
    _db ??= await initializeDb();
    return _db!;
  }

  Future<Database> initializeDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = "${dir.path}loginedUser.db";
    var dbTodos = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbTodos;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $tblTodo($colId INTEGER PRIMARY KEY, $colTitle TEXT)");
  }

  Future<int> insertTodo(UserDb userDb) async {
    Database db = await this.db;
    var result = await db.insert(tblTodo, userDb.toMap());
    return result;
  }

  Future<String> getTodos(String id) async {
    Database db = await this.db;
    var result =
    await db.rawQuery("SELECT * FROM $tblTodo WHERE id = $id");
    String deneme =result[0]["userid"].toString();
    return deneme;
  }
  Future<String>kullaniciSorgu(String id) async {
    Database db = await this.db;
    var result =
    await db.rawQuery("SELECT * FROM $tblTodo WHERE id = $id");
    String deneme =result[0]["userid"].toString();
    return deneme;
  }


  Future<int> getCount() async {
    Database db = await this.db;
    var result = Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(*) FROM $tblTodo"));

    return result!;
  }

  Future<int> updateTodo(UserDb todo) async {
    Database db = await this.db;
    var result = await db.update(tblTodo, todo.toMap(),
        where: "$colId = ?", whereArgs: [todo.id]);
    return result;
  }


  Future<int> deleteTodo(int id) async {
    Database db = await this.db;
    var result = await db.delete(tblTodo,  where: "$colId = ?", whereArgs: [id]);
    debugPrint("Kullanıcı başarıyla Çıkış yaptı");
    return result;
  }
  Future getBalance(String id) async {
    Database db = await this.db;
    var result =
    await db.rawQuery("SELECT * FROM $tblTodo WHERE id = $id");
    String deneme =result[0]["userid"].toString();
    // print("Kullanıcı Başarıyla Giriş yaptı userid = ${result[0]["userid"].toString()}");
      await BalanceControl().increaseBalance(result[0]["userid"].toString());
      return print("Kullanıcı cüzdanı arttı");


  }


}
