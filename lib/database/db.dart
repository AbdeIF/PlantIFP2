import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart';

class DB {
  DB._();
  static final DB instance = DB._();
  static sql.Database? _database;

  Future<sql.Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<sql.Database> _initDatabase() async {
    final path = join(await sql.getDatabasesPath(), 'plantifp2.db');

    return await sql.openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(sql.Database db, int version) async {
    await db.execute('''
      CREATE TABLE superuser (
        id INTEGER PRIMARY KEY,
        email TEXT,
        senha TEXT
      )
    ''');

    await _inicializarSuperUsuario(db); // Inicializar super usuário
  }

  Future<void> _inicializarSuperUsuario(sql.Database db) async {
    final email = 'superuser@gmail.com';
    final senha = '123456';

    await db.insert(
      'superuser',
      {'email': email, 'senha': senha},
      conflictAlgorithm: sql.ConflictAlgorithm.ignore,
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
  static Future<void> createTables(sql.Database database) async {
    await database.execute('''CREATE TABLE plants(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      img TEXT,
      nome_p TEXT,
      nome_c TEXT,
      descricao TEXT,
      periculosidade TEXT 
      )''');
  }

  static Future<sql.Database> db() async{
    return sql.openDatabase("database_name.db", version: 1,
      onCreate: (sql.Database database, int version) async{
        await createTables(database);
      }
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
        conflictAlgorithm: sql.ConflictAlgorithm.replace);

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
