//
//import 'package:controle_estoque_c317_flutter/model/Produto.dart';
//import 'package:sqflite/sqflite.dart';
//import 'package:controle_estoque_c317_flutter/factory/FactoryConnection.dart';
//import 'package:path/path.dart';
//
//
//// Usando o padrao singleton de classes
//// Esse padrao so retorna uma unica instanbcia idependente de quantas instancia
//// seja feita
//// normalmenete utilizado em classes que manipula
//// banco de dados ja que bd so precisa de uma unica instancia
//class ProdutoDAO {
//
//  static final String nomeTabela = "produto";
//  static final ProdutoDAO _produtoDAO = ProdutoDAO._internal();
//  Database? _db;
//
//  factory ProdutoDAO(){
//    return _produtoDAO;
//  }
//
//  ProdutoDAO._internal(){
//
//  }
//
//  get db async {
//
//    return _db != null ? _db : await inicializarDB();
//  }
//
//  _onCreate(Database db, int version) async {
//
//    String sql = "CREATE TABLE $nomeTabela ("
//        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
//        "nome_produto VARCHAR, "
//        "quantidade VARCHAR, "
//        "data DATETIME),";
//    await db.execute(sql);
//
//  }
//
//  inicializarDB() async {
//
//    final caminhoBancoDados = await getDatabasesPath();
//    print(caminhoBancoDados);
//    final localBancoDados = join(caminhoBancoDados, "banco_controle3.db");
//
//    var db = await openDatabase(localBancoDados, version: 1, onCreate: _onCreate );
//    return db;
//
//  }
//
//  Future<int> salvarProduto(Produto produto) async {
//
//    var bancoDados = await db;
//    int resultado = await bancoDados.insert(nomeTabela, produto.toMap() );
//    return resultado;
//
//  }
//
//  recuperarproduto() async {
//    var bancoDados = await db;
//    String sql = "SELECT * FROM $nomeTabela ORDER BY data DESC";
//    List produto = await bancoDados.rawQuery(sql);
//    return produto;
//  }
//
//  Future<int> atualizarproduto(Produto produto) async{
//
//    var bancoDados = await db;
//    return await bancoDados.update(
//      nomeTabela,
//        produto.toMap(),
//      where: "id = ?",
//      whereArgs: [produto.id]
//    );
//  }
//
//  Future<int> removerproduto(int id) async {
//    var bancoDados = await db;
//    return bancoDados.delete(
//      nomeTabela,
//        where: "id = ?",
//        whereArgs: [id]
//    );
//  }
//
//}
