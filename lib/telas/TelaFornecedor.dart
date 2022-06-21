import 'package:controle_estoque_c317_flutter/Cabecalho.dart';
import 'package:controle_estoque_c317_flutter/DAO/DatabaseHelper.dart';
//import 'package:controle_estoque_c317_flutter/DAO/FornecedorDAO.dart';
import 'package:controle_estoque_c317_flutter/model/Fornecedor.dart';
import 'package:controle_estoque_c317_flutter/model/Produto.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';


class TelaFornecedor extends StatefulWidget {
  @override
  _TelaFornecedorState createState() => _TelaFornecedorState();
}

class _TelaFornecedorState extends State<TelaFornecedor> {

  TextEditingController _nome_fornecedorController = TextEditingController();
  TextEditingController _localController = TextEditingController();
  var _db = DatabaseHelper();
  var _quantidade = 0;

  List<Fornecedor> _fornecedores = <Fornecedor>[];

  _exibirTelaCadastro({Fornecedor? fornecedor}){

    String textoSalvarAtualizar = "";

    if( fornecedor == null){ //salvar
      _nome_fornecedorController.text = "";
      _localController.text = "";
      textoSalvarAtualizar = "Salvar";
    }else{ // atualizar
      _nome_fornecedorController.text = fornecedor.nome_fornecedor.toString();
      _localController.text = fornecedor.local.toString();
      textoSalvarAtualizar = "Atualizar";
    }

    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("$textoSalvarAtualizar Fornecedor"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: _nome_fornecedorController,
                  autofocus: true,
                  decoration: InputDecoration(
                      labelText: "Nome Fornecedor",
                      hintText: "Digite Fornecedor nome..."
                  ),
                ),
                TextField(
                  controller: _localController,
                  decoration: InputDecoration(
                      labelText: "Local do Fornecedor",
                      hintText: "Digite local Fornecedor ..."
                  ),
                )
              ],
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancelar")
              ),
              TextButton(
                  onPressed: (){

                    //salvar
                    _salvarAtulizarfornecedor(fornecedorSelecionada: fornecedor);

                    Navigator.pop(context);
                  },
                  child: Text(textoSalvarAtualizar)
              )
            ],
          );
        }
    );

  }

  _recuperarFornenedor() async {

    //_fornecedores.clear();
    List fornecedorRecuperadas = await _db.recuperarfornecedor();
    //print("Lista fornecedores: " + fornecedorRecuperadas.toString());

    List<Fornecedor>? listaTemporaria = <Fornecedor>[];

    for( var item in fornecedorRecuperadas){
      Fornecedor fornecedor = Fornecedor.fromMap(item);
      listaTemporaria.add(fornecedor);
    }

    setState(() {
      _fornecedores = listaTemporaria!;
    });
    listaTemporaria = null;
  }

  _recuperarProdutoAcabando() async {

    _quantidade = 0;
    List produtoRecuperadas = await _db.recuperarproduto();

    var x;
    for( var item in produtoRecuperadas){
      Produto produto = Produto.fromMap(item);
      x = int.parse(produto.quantidade.toString());
      if(x<50){
        setState(() {
          _quantidade = _quantidade+1;
        });
      }
    }
  }

  _salvarAtulizarfornecedor( { Fornecedor? fornecedorSelecionada}) async {

    String nome_fornecedor = _nome_fornecedorController.text;
    String local = _localController.text;

    if( fornecedorSelecionada == null){ // salvar
      //print("data atual: " + DateTime.now().toString() );
      Fornecedor fornecedor = Fornecedor(nome_fornecedor, local, DateTime.now().toString() );
      int resultado = await _db.salvarfornecedor( fornecedor );
      //print("salvar fornecedor: " + resultado.toString() );

    }else{ //atualizar
      fornecedorSelecionada.nome_fornecedor = nome_fornecedor;
      fornecedorSelecionada.local = local;
      fornecedorSelecionada.data = DateTime.now().toString() ;
      int resultado = await _db.atualizarFornecedor(fornecedorSelecionada);
    }

    _nome_fornecedorController.clear();
    _localController.clear();

    _recuperarFornenedor();

  }

  _formatarData(String data){

    initializeDateFormatting("pt_BR", null);

    //var formatador = DateFormat("d/MM/y");
    var formatador = DateFormat.yMMMMd("pt_BR");
    DateTime dataConvertida = DateTime.parse(data);
    String dataFormatada = formatador.format(dataConvertida);

    return dataFormatada;

  }

  _removerFuncionario( int?  id) async {
    int quantidadeRemovida = await _db.removerfornecedor(id!);

    if(quantidadeRemovida >0){
    // remover algum
      _recuperarFornenedor();
    }

  }

  @override
  void initState(){
    //_db.inicializarDB();

    _recuperarProdutoAcabando();
    _recuperarFornenedor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    _recuperarFornenedor();

    return Scaffold(
      appBar: Cabecalho.cabecalho("Fornecedores",context,_quantidade),
      body: Column(
        children: <Widget>[
          Expanded(
              child: ListView.builder(
                  itemCount: _fornecedores.length,
                  itemBuilder: (context, index){

                    final item = _fornecedores[index];

                    return Card(
                      child: ListTile(
                        title: Text( item.nome_fornecedor.toString() ),
                        subtitle:Text("Local: ${item.local} - Data cadastro: ${_formatarData(item.data.toString())}") ,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min ,
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){
                                _exibirTelaCadastro(fornecedor: item);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: Icon(
                                  Icons.edit,
                                  color:Colors.green,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                showDialog(
                                    context: context,
                                    builder: (context){
                                      return AlertDialog(
                                        title: Text("Deseja mesmo Excluir esse Fornecedor?"),
                                        actions: <Widget>[
                                          TextButton(
                                              onPressed: () => Navigator.pop(context),
                                              child: Text("Cancelar")
                                          ),
                                          TextButton(
                                              onPressed: (){

                                                //Excluir
                                                _removerFuncionario( item.id);
                                                Navigator.pop(context);
                                              },
                                              child: Text("Excluir")
                                          )
                                        ],
                                      );
                                    }
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: Icon(
                                  Icons.remove_circle,
                                  color:Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
              )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          child: Icon(Icons.add),
          onPressed: (){
            _exibirTelaCadastro();
          }
      ),
    );
  }
}
