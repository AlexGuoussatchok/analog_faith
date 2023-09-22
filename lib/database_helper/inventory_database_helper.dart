import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class InventoryDatabaseHelper {
  late Database _database;

  // Singleton pattern to ensure only one instance of the database helper
  static final InventoryDatabaseHelper _instance = InventoryDatabaseHelper._internal();

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

  Future<int> addCamera(
      String brand,
      String model,
      String serialNumber,
      String purchaseDate,
      double pricePaid,
      String condition,
      String comments,
      ) async {
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


}
