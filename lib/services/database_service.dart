import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import '../models/pmatals.dart';

class DatabaseService extends ChangeNotifier {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    // Get the path to the app's internal storage
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'mataluna.sqlite');

    // Check if the database already exists in the internal storage
    bool exists = await databaseExists(path);

    if (!exists) {
      // If not, copy it from the assets folder
      ByteData data = await rootBundle.load('assets/mataluna.sqlite');
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write the copied data to the app's internal storage
      await File(path).writeAsBytes(bytes, flush: true);
      debugPrint('Database copied to internal storage.');
    } else {
      debugPrint('Database already exists in internal storage.');
    }

    // Open the database
    Database db = await openDatabase(path);
    debugPrint('Database opened.');

    // Check if the 'pmatals' table exists
    List<Map> result = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name='pmatals'");
    if (result.isEmpty) {
      debugPrint('Table "pmatals" does not exist.');
    } else {
      debugPrint('Table "pmatals" exists.');
    }

    return db;
  }

  Future<List<Pmatals>> getPmatals({bool favoriteOnly = false}) async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('pmatals', where: favoriteOnly ? 'fav = 1' : null);
    return List.generate(maps.length, (i) {
      return Pmatals.fromMap(maps[i]);
    });
  }

  Future<void> updateFavorite(Pmatals pmatal) async {
    final db = await database;
    pmatal.fav = !pmatal.fav;
    await db.update(
      'pmatals',
      pmatal.toMap(),
      where: 'id = ?',
      whereArgs: [pmatal.id],
    );
    notifyListeners();
  }

  Future<int> getTotalCount() async {
    final db = await database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM pmatals'))!;
  }

  Future<int> getFavoriteCount() async {
    final db = await database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM pmatals WHERE fav = 1'))!;
  }
}
