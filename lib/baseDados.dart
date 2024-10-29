import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class Basededados {
  static const nomebd = "bdadm.db";
  final int versao = 1;
  static Database? _basededados;
  Future<Database> get basededados async {
    if (_basededados != null) return _basededados!;
    _basededados = await _initDatabase();
    return _basededados!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), nomebd);
    return await openDatabase(
      path,
      version: versao,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Criar a tabela utilizadores
    await db.execute('''
      CREATE TABLE utilizadores (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        login TEXT NOT NULL,
        password TEXT NOT NULL,
        email TEXT NOT NULL,
        telefone TEXT NOT NULL
      )
    ''');
  }

  Future<void> criatabela() async {
    Database db = await basededados;
    await db.execute('''
      CREATE TABLE IF NOT EXISTS utilizadores (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        login TEXT NOT NULL,
        password TEXT NOT NULL,
        email TEXT NOT NULL,
        telefone TEXT NOT NULL
      )
    ''');
  }

  Future<void> apagatabela() async {
    Database db = await basededados;
    await db.execute('DROP TABLE IF EXISTS utilizadores');
  }

  Future<void> inserirvalor(
      String login, String password, String email, String telefone) async {
    Database db = await basededados;
    await db.rawInsert(
        'INSERT INTO utilizadores(login, password, email, telefone) VALUES(?, ?, ?, ?)',
        [login, password, email, telefone]);
  }

  Future<void> consulta() async {
    Database db = await basededados;
    List<Map> resultado = await db.rawQuery('SELECT * FROM utilizadores');
    for (var linha in resultado) {
      if (kDebugMode) {
        print(linha);
      }
    }
  }
}
