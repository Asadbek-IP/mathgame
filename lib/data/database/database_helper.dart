import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:mathgame/data/models/difficulty.dart';
import 'package:mathgame/data/models/level.dart';
import 'package:mathgame/data/models/world.dart';
import 'package:mathgame/util/constants.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _dbName = "math_game.db";
  static const _dbVersion = 1;

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  final _changeController = StreamController<int>.broadcast();

  Stream<int> get changeStream => _changeController.stream;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _dbName);
    await _copyDatabase(path);
    return await openDatabase(path, version: _dbVersion);
  }

  Future<void> _copyDatabase(String path) async {
    var exists = await databaseExists(path);
    if (!exists) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}
      ByteData data = await rootBundle.load("assets/database/math_game.db");
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
    }
  }

  Future<List<Difficulty>> getAllDifficulties() async {
    Database database = await instance.database;
    var res = await database.query("difficulty");
    return res.map((e) => Difficulty.fromMap(e)).toList();
  }

  Future<List<World>> getWorldsByDifficulty(int difficultyId) async {
    Database database = await instance.database;
    var res = await database.rawQuery('''
      SELECT COUNT(level.id) as unlocked_count, IFNULL(SUM(level.stars), 0) as stars, 
      world.id, world.allowed_operations, world.image, world.min, world.max, world.difficulty FROM world
      LEFT JOIN level
      ON world.id = level.world AND level.unlocked = 1 WHERE world.difficulty = $difficultyId GROUP BY world.id
    ''');
    return res.map((e) => World.fromMap(e)).toList();
  }

  Future<World> getWorldById(int worldId) async {
    Database database = await instance.database;
    var res = await database.rawQuery('''
      SELECT COUNT(level.id) as unlocked_count, IFNULL(SUM(level.stars), 0) as stars, 
      world.id, world.allowed_operations, world.image, world.min, world.max, world.difficulty FROM world
      LEFT JOIN level
      ON world.id = level.world AND level.unlocked = 1 WHERE world.id = $worldId GROUP BY world.id
    ''');
    return World.fromMap(res[0]);
  }

  Future<List<Level>> getLevelsByWorld(World world) async {
    Database database = await instance.database;
    var res = await database.query("level", where: "world = ?", whereArgs: [world.id]);
    return res.map((e) => Level.fromMap(e)).toList();
  }

  Future<void> changeLevelStar(Level level, int newStars) async {
    Database database = await instance.database;
    await database.update("level", {"stars": newStars}, where: "id = ?", whereArgs: [level.id]);
    await unlockNextLevel(database, level);
    _changeController.add(level.id * 10 + newStars);
  }

  Future<void> unlockNextLevel(Database database, Level level) async {
    if (level.id % (levelEachWorld * worldCount) != 0) {
      await database.update("level", {"unlocked": 1}, where: "id = ?", whereArgs: [level.id + 1]);
    }
  }
}
