import 'package:sqflite/sqflite.dart';

abstract class DatabaseHelperContract {
  Future<void> validateAndStartDatabase();
  Future<bool> insertIntoDatabase({required Object event});
  Future<void> updateDatabase({required Object event});
  Future<List<Map<String, dynamic>>> getAllSavedEvents();
  Future<void> createDatabase({required Database database});
}