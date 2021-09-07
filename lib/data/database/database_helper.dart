import 'package:restaurant/data/model/restaurant.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _tableRestaurant = 'restaurants';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/restaurant.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_tableRestaurant (
             id TEXT PRIMARY KEY,
             name TEXT,
             description TEXT,
             pictureId TEXT,
             city TEXT,
             rating REAL
           )     
        ''');
      },
      version: 1,
    );

    return db;
  }

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initializeDb();
    }

    return _database;
  }

  Future<void> insertRestaurant(Restaurants restaurant) async {
    final db = await database;
    await db!.insert(_tableRestaurant, restaurant.toJson());
  }

  Future<List<Restaurants>> getRestaurants() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tableRestaurant);
    print(results);
    return results.map((res) => Restaurants.fromJson(res)).toList();
  }

  Future<Map> getFavorite(String id) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db!.query(
      _tableRestaurant,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> removeRestaurant(String id) async {
    final db = await database;

    await db!.delete(
      _tableRestaurant,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}