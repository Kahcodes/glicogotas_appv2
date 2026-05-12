import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class PageDatabase {
  static final PageDatabase instance = PageDatabase._init();
  static Database? _database;

  PageDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('pages.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE pages (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        page_number INTEGER NOT NULL
      )
    ''');
  }

  Future<void> saveCurrentPage(int page) async {
    final db = await instance.database;
    await db.insert(
      'pages',
      {'page_number': page},
      conflictAlgorithm:
          ConflictAlgorithm.replace, // Substitui registros antigos.
    );
  }

  Future<int> getCurrentPage() async {
    final db = await instance.database;
    final result = await db.query(
      'pages',
      limit: 1,
      orderBy: 'id DESC', // Busca o registro mais recente.
    );

    return result.isNotEmpty ? result.first['page_number'] as int : 1;
  }

  Future close() async {
    final db = _database;
    if (db != null) await db.close();
  }
}
