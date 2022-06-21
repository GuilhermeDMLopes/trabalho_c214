
import 'package:controle_estoque_c317_flutter/model/Fornecedor.dart';
import 'package:controle_estoque_c317_flutter/model/Usuario.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:controle_estoque_c317_flutter/model/Produto.dart';



// Usando o padrao singleton de classes
// Esse padrao so retorna uma unica instanbcia idependente de quantas instancia
// seja feita
// normalmenete utilizado em classes que manipula
// banco de dados ja que bd so precisa de uma unica instancia
class DatabaseHelper {

  static final String nomeTabelaFornecedor = "fornecedor";
  static final String nomeTabelaProduto = "produto";
  static final String nomeTabelaUsuario = "usuario";
  static final DatabaseHelper _fornecedorDAO = DatabaseHelper._internal();
  Database? _db;

  factory DatabaseHelper(){
    return _fornecedorDAO;
  }

  DatabaseHelper._internal(){

  }

  get db async {

    return _db != null ? _db : inicializarDB();
  }

  _onCreateFornecedor(Database db, int version) async {

    String sql = "CREATE TABLE IF NOT EXISTS $nomeTabelaFornecedor ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "nome_fornecedor VARCHAR, "
        "local TEXT, "
        "data DATETIME)";

    await db.execute(sql);

    sql = "CREATE TABLE IF NOT EXISTS $nomeTabelaProduto ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "nome_produto VARCHAR, "
        "quantidade VARCHAR, "
        "data DATETIME)";
    await db.execute(sql);

    sql = "CREATE TABLE IF NOT EXISTS $nomeTabelaUsuario ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "email_usuario VARCHAR, "
        "senha VARCHAR) ";

    await db.execute(sql);

  }

  inicializarDB() async {

    final caminhoBancoDados = await getDatabasesPath();
    print(caminhoBancoDados);
    final localBancoDados = join(caminhoBancoDados, "banco_controle23.db");

    var db = await openDatabase(localBancoDados, version: 1, onCreate: _onCreateFornecedor );
    return db;

  }

  Future<int> salvarfornecedor(Fornecedor fornecedor) async {

    var bancoDados = await db;
    int resultado = await bancoDados.insert(nomeTabelaFornecedor, fornecedor.toMap() );
    return resultado;

  }

  recuperarfornecedor() async {
    var bancoDados = await db;
    String sql = "SELECT * FROM $nomeTabelaFornecedor ORDER BY data DESC";
    List fornecedor = await bancoDados.rawQuery(sql);
    return fornecedor;
  }

  Future<int> atualizarFornecedor(Fornecedor fornecedor) async{

    var bancoDados = await db;
    return await bancoDados.update(
        nomeTabelaFornecedor,
        fornecedor.toMap(),
        where: "id = ?",
        whereArgs: [fornecedor.id]
    );
  }

  Future<int> removerfornecedor(int id) async {
    var bancoDados = await db;
    return bancoDados.delete(
        nomeTabelaFornecedor,
        where: "id = ?",
        whereArgs: [id]
    );
  }
  Future<int> salvarProduto(Produto produto) async {

    var bancoDados = await db;
    int resultado = await bancoDados.insert(nomeTabelaProduto, produto.toMap() );
    return resultado;

  }

  recuperarproduto() async {
    var bancoDados = await db;
    String sql = "SELECT * FROM $nomeTabelaProduto ORDER BY data DESC";
    List produto = await bancoDados.rawQuery(sql);
    return produto;
  }

  Future<int> atualizarproduto(Produto produto) async{

    var bancoDados = await db;
    return await bancoDados.update(
        nomeTabelaProduto,
        produto.toMap(),
        where: "id = ?",
        whereArgs: [produto.id]
    );
  }

  Future<int> removerproduto(int id) async {
    var bancoDados = await db;
    return bancoDados.delete(
        nomeTabelaProduto,
        where: "id = ?",
        whereArgs: [id]
    );
  }
  Future<int> salvarUsuario(Usuario Usuario) async {

    var bancoDados = await db;
    int resultado = await bancoDados.insert(nomeTabelaUsuario, Usuario.toMap() );
    return resultado;

  }
  recuperarUsuario() async {
    var bancoDados = await db;
    String sql = "SELECT * FROM $nomeTabelaUsuario";
    List usuario = await bancoDados.rawQuery(sql);
    return usuario;
  }

}
