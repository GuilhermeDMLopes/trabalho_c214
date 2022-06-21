//import 'package:controle_estoque_c317_flutter/model/Fornecedor.dart';
//import 'package:sqflite/sqflite.dart';
//import 'package:path/path.dart';
//
//class FactoryConnection{
//
//  _onCreate(Database db, int version) async {
//
//    String sql = "CREATE TABLE fornecedor ("
//        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
//        "nome_fornecedor VARCHAR, "
//        "local TEXT, "
//        "data DATETIME);"
//
//        "CREATE TABLE produto ("
//        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
//        "nome_produto VARCHAR, "
//        "quantidade VARCHAR, "
//        "data DATETIME)";
//    await db.execute(sql);
//
//  }
//
//  inicializarDB() async {
//
//    final caminhoBancoDados = await getDatabasesPath();
//    print(caminhoBancoDados);
//    final localBancoDados = join(caminhoBancoDados, "banco_controle8.db");
//
//    var db = await openDatabase(localBancoDados, version: 1, onCreate: _onCreate );
//    return db;
//
//  }
//}