import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// Stockage local SQLite des dossiers patients.
/// NOTE : chiffrement AES-256 local non inclus (voir README, section Sécurité).
class DatabaseService {
  static Database? _db;

  static Future<Database> get db async {
    return _db ??= await openDatabase(
      join(await getDatabasesPath(), 'meoz.db'),
      version: 1,
      onCreate: (d, v) => d.execute(
        'CREATE TABLE records('
        'id INTEGER PRIMARY KEY AUTOINCREMENT, '
        'module TEXT, result TEXT, confidence REAL, '
        'image_path TEXT, created_at TEXT)',
      ),
    );
  }

  static Future<void> insert(Map<String, Object?> record) async {
    await (await db).insert('records', record);
  }

  static Future<List<Map<String, Object?>>> all() async {
    return (await db).query('records', orderBy: 'id DESC');
  }
}
