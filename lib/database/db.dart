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
        id INTEGER PRIMARY KEY,
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

// ============================================ DB TABLE PLANTS ========================================

class DBPlant {
  static Future<void> createTables(Database database) async {
    await database.execute('''CREATE TABLE plants(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      img TEXT,
      nome_p TEXT,
      nome_c TEXT,
      descricao TEXT,
      periculosidade TEXT 
      )''');
  }

  static Future<Database> db() async {
    final path = join(await getDatabasesPath(), 'plantifp2.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> createData(String img, String nome_p, String? nome_c,
      String? descricao, String? periculosidade) async {
    final db = await DBPlant.db();

    final plants = {
      'img': img,
      'nome_p': nome_p,
      'nome_c': nome_c,
      'descricao': descricao,
      'periculosidade': periculosidade
    };
    final id = await db.insert('plants', plants,
        conflictAlgorithm: ConflictAlgorithm.replace);

    return id;
  }

  static Future<List<Map<String, dynamic>>> getAllData() async {
    final db = await DBPlant.db();
    return db.query('plants', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getSingleData(int id) async {
    final db = await DBPlant.db();
    return db.query('plants', where: 'id = ?', whereArgs: [id], limit: 1);
  }

  static Future<int> updateData(int id, String img, String nome_p,
      String? nome_c, String? descricao, String? periculosidade) async {
    final db = await DBPlant.db();
    final plants = {
      'img': img,
      'nome_p': nome_p,
      'nome_c': nome_c,
      'descricao': descricao,
      'periculosidade': periculosidade,
    };
    final result =
        await db.update('plants', plants, where: 'id = ?', whereArgs: [id]);

    return result;
  }

  static Future<void> deleteData(int id) async {
    final db = await DBPlant.db();
    try {
      await db.delete('plants', where: 'id = ?', whereArgs: [id]);
    } catch (e) {}
  }
}
