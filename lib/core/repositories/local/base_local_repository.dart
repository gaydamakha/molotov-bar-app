import 'package:sqflite/sqflite.dart';

abstract class BaseLocalRepository {
  final Database connection;

  BaseLocalRepository(this.connection);
}
