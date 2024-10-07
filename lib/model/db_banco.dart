import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';


class Bd {
  static Database? _database;

  // Singleton para garantir que uma única instância do banco seja usada
  static final Bd instance = Bd._privateConstructor();
  Bd._privateConstructor();

  // Método para obter a instância do banco de dados
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _inicializaBd();
    return _database!;
  }

  Future<Database> _inicializaBd() async {
    final databasePath = await getApplicationSupportDirectory(); // Usando o diretório de suporte
    final path = join(databasePath.path, 'lista.db');

    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE tarefa(id INTEGER PRIMARY KEY, nome TEXT, descricao TEXT)',
        );
      },
      version: 1,
    );
  }

  // Inserir Dados
  Future<void> criarTafera(String nome, String descricao) async {
    final db = await database; // Obtém a instância do banco
    await db.insert(
          'tarefa',
      {'descricao': descricao, 'nome': nome},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Consultar Dados
  Future<List<Map<String, dynamic>>> getTarefa() async {
    final db = await database; // Obtém a instância do banco
    return await db.query('tarefa');
  }

  // Atualizar Dados
  Future<void> updateTarefa(int id, String nome, String descricao) async {
    final db = await database; // Obtém a instância do banco
    await db.update(
      'tarefa',
      {'nome': nome, 'descricao': descricao},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Deletar Dados
  Future<void> deleteTarefa(int id) async {
    final db = await database; // Obtém a instância do banco
    await db.delete(
      'tarefa',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
