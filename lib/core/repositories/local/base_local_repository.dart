import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

abstract class BaseLocalRepository {
  late Database _connection;

  Future<Database> get connection async {
    _connection = await _initConnection();
    return _connection;
  }

  Future<Database> _initConnection() async {
    return await openDatabase(
      'cocktails.db',
      version: 1,
      onCreate: _createTable,
    );
  }

  Future<void> _createTable(Database db, int version) async {
    var dbStructure = await rootBundle.loadString('assets/sql/db.sql');
    await db.execute(dbStructure);
  }
}
