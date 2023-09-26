import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DarkroomNotesDatabaseHelper {
  late Database _database;

  // Singleton pattern to ensure only one instance of the database helper
  static final DarkroomNotesDatabaseHelper _instance =
  DarkroomNotesDatabaseHelper._internal();

  factory DarkroomNotesDatabaseHelper() {
    return _instance;
  }

  DarkroomNotesDatabaseHelper._internal();

  Future<void> initializeDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'darkroom_notes.db');
    _database = await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  void _createDatabase(Database db, int version) async {
    // Create 'film_developing_notes' table
    await db.execute('''
      CREATE TABLE film_developing_notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT,
        film_number INTEGER,
        film TEXT,
        film_shooting_start_date TEXT,
        film_shooting_end_date TEXT,
        ISO_shut INTEGER,
        film_type TEXT,
        film_size TEXT,
        film_expired INTEGER,
        film_expiration_date TEXT,
        camera TEXT,
        lenses TEXT,
        developer TEXT,
        lab TEXT,
        dilution TEXT,
        developing_time TEXT,
        temperature TEXT,       
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

// Add methods to interact with the 'film_developing_notes' table here
}
