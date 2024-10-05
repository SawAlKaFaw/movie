import 'package:movie/data/model/movie.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._create();
  static Database? _database;
  static const String _databaseName = "movie.db";
  static const String _tableName = "my_movie";

  DatabaseHelper._create();

  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database> getDatabase() async {
    if (_database != null) return _database!;
    _database = await _createDatabase();
    return _database!;
  }

  Future<Database> _createDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $_tableName(id INTEGER PRIMARY KEY, original_title TEXT, backdrop_path TEXT, overview TEXT, vote_count INTEGER)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertMovie(Movie movie) async {
    final db = await getDatabase();
    await db.insert(
      _tableName,
      movie.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Movie>> getAllMovies() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    return List.generate(maps.length, (movie) {
      return Movie.fromMap(maps[movie]);
    });
  }
}