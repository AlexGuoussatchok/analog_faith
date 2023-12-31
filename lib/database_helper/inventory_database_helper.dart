import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class InventoryDatabaseHelper {
  late Database _database;

  // Singleton pattern to ensure only one instance of the database helper
  static final InventoryDatabaseHelper _instance = InventoryDatabaseHelper
      ._internal();

  factory InventoryDatabaseHelper() {
    return _instance;
  }

  InventoryDatabaseHelper._internal();

  Future<void> initializeDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'inventory.db');
    _database = await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  void _createDatabase(Database db, int version) async {
    // Create 'my_cameras' table
    await db.execute('''
      CREATE TABLE my_cameras (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        brand TEXT,
        model TEXT,
        serial_number TEXT,
        purchase_date TEXT,
        price_paid REAL,
        condition TEXT,
        film_loaded TEXT,
        film_load_date TEXT,
        average_price REAL,
        comments TEXT
      )
    ''');

    // Create 'my_lenses' table
    await db.execute('''
      CREATE TABLE my_lenses (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        brand TEXT,
        model TEXT,
        mount TEXT,
        serial_number TEXT,
        purchase_date TEXT,
        price_paid REAL,
        condition TEXT,
        average_price REAL,
        comments TEXT
      )
    ''');

    // Create 'my_films' table
    await db.execute('''
      CREATE TABLE my_films (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        brand TEXT,
        film_name TEXT,
        film_type TEXT,
        film_size TEXT,
        film_iso TEXT,
        frames_number INTEGER,
        film_expired INTEGER,
        expiration_date TEXT,
        quantity INTEGER,
        price_paid REAL,
        comments TEXT
      )
    ''');
  }

  Future<Database> get database async {
    if (_database.isOpen) {
      return _database;
    } else {
      await initializeDatabase();
      return _database;
    }
  }

  // Define the getMyCameras method to fetch camera inventory
  Future<List<Map<String, dynamic>>> getMyCameras() async {
    final db = await database;
    return await db.query('my_cameras');
  }

  Future<int> addCamera(String brand,
      String model,
      String serialNumber,
      String purchaseDate,
      double pricePaid,
      String condition,
      String comments,) async {
    final db = await database;
    final id = await db.insert(
      'my_cameras',
      {
        'brand': brand,
        'model': model,
        'serial_number': serialNumber,
        'purchase_date': purchaseDate,
        'price_paid': pricePaid,
        'condition': condition,
        'comments': comments,
      },
    );
    return id;
  }

  Future<List<Map<String, dynamic>>> getMyLenses() async {
    final db = await database;
    return await db.query('my_lenses');
  }

  Future<int> addLens(String brand,
      String model,
      String mount,
      String serialNumber,
      String purchaseDate,
      double pricePaid,
      String condition,
      String comments,) async {
    final db = await database;
    final id = await db.insert(
      'my_lenses',
      {
        'brand': brand,
        'model': model,
        'mount': mount,
        'serial_number': serialNumber,
        'purchase_date': purchaseDate,
        'price_paid': pricePaid,
        'condition': condition,
        'comments': comments,
      },
    );
    return id;
  }

  static const String filmTable = 'my_films';

  // Add a method to get film inventory
  Future<List<Map<String, dynamic>>> getMyFilms() async {
    final db = await database;
    return await db.query(filmTable);
  }

  // Add a method to add a film to the inventory
  Future<int> addFilm(String brand,
      String filmName,
      String filmType,
      String filmSize,
      String filmIso,
      int framesNumber,
      bool filmExpired,
      String expirationDate,
      int quantity,
      double pricePaid,
      String comments,) async {
    final db = await database;
    final id = await db.insert(
      filmTable,
      {
        'brand': brand,
        'film_name': filmName,
        'film_type': filmType,
        'film_size': filmSize,
        'film_iso': filmIso,
        'frames_number': framesNumber,
        'film_expired': filmExpired ? 1 : 0, // Convert boolean to integer
        'expiration_date': expirationDate,
        'quantity': quantity,
        'price_paid': pricePaid,
        'comments': comments,
      },
    );
    return id;
  }

  Future<void> updateCamera(int id, String brand, String model, String serialNumber,
      String purchaseDate, double pricePaid, String condition, String comments) async {
    await _database.update(
      'my_cameras', // Replace with your actual table name
      {
        'brand': brand,
        'model': model,
        'serial_number': serialNumber,
        'purchase_date': purchaseDate,
        'price_paid': pricePaid,
        'condition': condition,
        'comments': comments,
        // Add other fields and their values here
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteCamera(int id) async {
    final db = await database;
    await db.delete(
      'my_cameras',
      where: 'id = ?',
      whereArgs: [id],
    );
  }



}
