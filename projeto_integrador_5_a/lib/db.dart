import 'package:sqflite/sqflite.dart' as sqflite;

class TBContato {

  static Future<void> criaTabelaContato(sqflite.Database database) async {
    await database.execute(
      """
        CREATE TABLE contato (
          id integer primary key autoincrement not null,
          nome varchar(100) not null,
          telefone varchar(20) not null,
          email varchar(100) not null
        )
      """
    );
  } 

  static Future<sqflite.Database> conexao() {

    return sqflite.openDatabase(
      "database_name.db",
      version: 1,
      onCreate: (sqflite.Database database, int version) async {
        await criaTabelaContato(database);
      }
    );
  }

  static Future<int> insert(String nome, String telefone, String email) async {

    final db = await TBContato.conexao();
    final data = {
      'nome': nome,
      'telefone': telefone,
      'email': email
    };

    final id = await db.insert('contato', data, conflictAlgorithm: sqflite.ConflictAlgorithm.replace);

    return id;
  }

  static Future<List<Map<String, dynamic>>> all() async {

    final db = await TBContato.conexao();

    return db.query('contato', orderBy: 'id');
  }

  static Future<int> update(int id, String nome, String telefone, String email) async {

    final db = await TBContato.conexao();
    final data = {
      'nome': nome,
      'telefone': telefone,
      'email': email
    };

    return db.update('contato', data, where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> delete(int id) async {
    final db = await TBContato.conexao();

    try {
      await db.delete('contato', where: 'id = ?', whereArgs: [id]);
    } catch (e) {}
  }
}
