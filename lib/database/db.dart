import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  DB._();
  static final DB instance = DB._();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'plantifp2.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE superuser (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT,
        senha TEXT
      )
    ''');

    await _inicializarSuperUsuario(db); // Inicializar super usuário
  }

  Future<void> _inicializarSuperUsuario(Database db) async {
    final email = 'superuser@gmail.com';
    final senha = '123456';

    await db.insert(
      'superuser',
      {'email': email, 'senha': senha},
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<bool> validarLogin(String email, String senha) async {
    final db = await database;
    final result = await db.query(
      'superuser',
      where: 'email = ? AND senha = ?',
      whereArgs: [email, senha],
    );

    return result.isNotEmpty;
  }
}
