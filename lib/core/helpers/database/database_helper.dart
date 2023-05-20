import 'dart:io';
import 'dart:developer';


import 'package:sqflite/sqflite.dart';

import '../../constants/app_constants_utils.dart';
import 'database_helper_contract.dart';

class DatabaseHelper implements DatabaseHelperContract {
  static const databaseName = 'pokedex_local';
  Database? database;

  DatabaseHelper() {
    validateAndStartDatabase();
  }

  @override
  Future<void> validateAndStartDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = databasePath;
    try {
      if (Directory(path).existsSync() == false) {
        await Directory(path).create(recursive: true);
      }
      database = await openDatabase(
        '$path${'/${AppConstantsUtils.databaseName}'}',
        version: 1,
        onCreate: (db, version) => createDatabase(database: db),
      );
    } catch (e, stacktrace) {
      log('Database error', stackTrace: stacktrace);
    }
  }

  @override
  Future<bool> insertIntoDatabase({required Object event}) async {
    if (database == null) {
      await validateAndStartDatabase();
    }
    try {
      int? result = await database?.rawInsert(
        'INSERT INTO $databaseName() VALUES ()',
        List.from([]),
      );
      return result != 0;
    } catch (e, stacktrace) {
      log('Database error', error: e.toString(), stackTrace: stacktrace);
    }
    return false;
  }

  @override
  Future<void> updateDatabase({required Object event}) async {
    if (database == null) {
      await validateAndStartDatabase();
    }
    await database
        ?.update(databaseName, Map.identity(), where: 'key = ?', whereArgs: [
      0,
    ]).then(
      (value) => log(
        'Database updated $value',
      ),
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getAllSavedEvents() async {
    if (database == null) {
      await validateAndStartDatabase();
    }
    List<Map<String, dynamic>> results = await database!.rawQuery(
      'SELECT * FROM $databaseName',
    );
    return results;
  }

  @override
  Future<void> createDatabase({required Database database}) async {
    database.execute(
      'CREATE TABLE $databaseName ()',
    );
  }
}
