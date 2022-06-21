//
//import 'package:controle_estoque_c317_flutter/model/Fornecedor.dart';
//import 'package:sqflite/sqflite.dart';
//import 'package:controle_estoque_c317_flutter/factory/FactoryConnection.dart';
//import 'package:path/path.dart';
//
//
//
//// Usando o padrao singleton de classes
//// Esse padrao so retorna uma unica instanbcia idependente de quantas instancia
//// seja feita
//// normalmenete utilizado em classes que manipula
//// banco de dados ja que bd so precisa de uma unica instancia
//class FornecedorDAO {
//
//  static final String nomeTabela = "fornecedor";
//  static final FornecedorDAO _fornecedorDAO = FornecedorDAO._internal();
//  Database? _db;
//
//  factory FornecedorDAO(){
//    return _fornecedorDAO;
//  }
//
//  FornecedorDAO._internal(){
//
//  }
//
//  get db async {
//
//    //if( _db != null ){
//    //  return _db;
//    //}else{
//    //  _db = await inicializarDB();
//    //  return _db;
//    //}
//    return _db != null ? _db : inicializarDB();
//  }
//
//  _onCreate(Database db, int version) async {
//
//    String sql = "CREATE TABLE $nomeTabela ("
//        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
//        "nome_fornecedor VARCHAR, "
//        "local TEXT, "
//        "data DATETIME)";
//    await db.execute(sql);
//
//  }
//
//  inicializarDB() async {
//
//    final caminhoBancoDados = await getDatabasesPath();
//    print(caminhoBancoDados);
//    final localBancoDados = join(caminhoBancoDados, "banco_controle.db");
//
//    var db = await openDatabase(localBancoDados, version: 1, onCreate: _onCreate );
//    return db;
//
//  }
//
//  Future<int> salvarfornecedor(Fornecedor fornecedor) async {
//
//    var bancoDados = await db;
//    int resultado = await bancoDados.insert(nomeTabela, fornecedor.toMap() );
//    return resultado;
//
//  }
//
//  recuperarfornecedor() async {
//    var bancoDados = await db;
//    String sql = "SELECT * FROM $nomeTabela ORDER BY data DESC";
//    List fornecedor = await bancoDados.rawQuery(sql);
//    return fornecedor;
//  }
//
//  Future<int> atualizarFornecedor(Fornecedor fornecedor) async{
//
//    var bancoDados = await db;
//    return await bancoDados.update(
//      nomeTabela,
//        fornecedor.toMap(),
//      where: "id = ?",
//      whereArgs: [fornecedor.id]
//    );
//  }
//
//  Future<int> removerfornecedor(int id) async {
//    var bancoDados = await db;
//    return bancoDados.delete(
//      nomeTabela,
//        where: "id = ?",
//        whereArgs: [id]
//    );
//  }
//
//}
