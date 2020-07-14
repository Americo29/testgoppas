import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:testgoppas/src/models/usuario_model.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'User.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE User ('
          'id INTEGER PRIMARY KEY,'
          'tipoDocumento TEXT,'
          'numeroIdentificacion TEXT,'
          'telefonoMovil TEXT,'
          'nombres TEXT,'
          'apellidos TEXT,'
          'correo TEXT,'
          'password TEXT'
          ')');
    });
  }

  Future<int> saveUser(Usuario user) async {
    final db = await database;
    final res = db.insert('User', user.toJson());
    return res;
  }

  Future<Usuario> getLogin(String correo, String password) async {
    final db = await database;
    var res = await db.rawQuery(
        "SELECT * FROM user WHERE correo = '$correo' and password = '$password'");
    return res.isNotEmpty ? Usuario.fromJson(res.first) : null;
  }
}
