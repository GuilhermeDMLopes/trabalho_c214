import 'package:controle_estoque_c317_flutter/Cabecalho.dart';
import 'package:controle_estoque_c317_flutter/model/Fornecedor.dart';
//import 'package:controle_estoque_c317_flutter/DAO/ProdutoDAO.dart';

import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:controle_estoque_c317_flutter/model/Produto.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:controle_estoque_c317_flutter/DAO/DatabaseHelper.dart';

import 'package:intl/intl.dart';

class TelaProduto extends StatefulWidget {
  @override
  _TelaProdutoState createState() => _TelaProdutoState();
}

class _TelaProdutoState extends State<TelaProduto> {

  TextEditingController _nome_produtoController = TextEditingController();
  TextEditingController _quantidadeController = TextEditingController();
  var _quantidade = 0;
  var _db = DatabaseHelper();
  String? _selectedValue = 'Escolha o Fornecedor';
  List<String> items = ['Escolha o Fornecedor'];
  List<String> _fornecedores = [];
  _recuperarFornenedor() async {

    //_fornecedores.clear();
    List fornecedorRecuperadas = await _db.recuperarfornecedor();
    //print("Lista fornecedores: " + fornecedorRecuperadas.toString());

    List<String>? listaTemporaria = <String>[];

    for( var item in fornecedorRecuperadas){
      Fornecedor fornecedor = Fornecedor.fromMap(item);
      items.add(fornecedor.nome_fornecedor.toString());
    }
    print(items);

//    setState(() {
//      items = listaTemporaria!;
//    });
    listaTemporaria = null;
  }

  List<Produto> _produtos = <Produto>[];

  _exibirTelaCadastro({Produto? produto}){

    String textoSalvarAtualizar = "";

    if( produto == null){ //salvar
      _nome_produtoController.text = "";
      _quantidadeController.text = "";
      textoSalvarAtualizar = "Salvar";
    }else{ // atualizar
      _nome_produtoController.text = produto.nome_produto.toString();
      _quantidadeController.text = produto.quantidade.toString();
      textoSalvarAtualizar = "Atualizar";
    }

    showDialog(
        context: context,
        builder: (context){
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState)
              {
                return AlertDialog(
                  title: Text("$textoSalvarAtualizar Produto"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        keyboardType: TextInputType.text,
                        controller: _nome_produtoController,
                        autofocus: true,
                        decoration: InputDecoration(
                            labelText: "Nome produto",
                            hintText: "Digite produto nome..."
                        ),
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        controller: _quantidadeController,
                        decoration: InputDecoration(
                            labelText: "Quantidade do produto",
                            hintText: "Digite quantidade produto ..."
                        ),
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          hint: Text(
                            '$_selectedValue',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme
                                  .of(context)
                                  .hintColor,
                            ),
                          ),
                          items: items
                              .map((item) =>
                              DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                              .toList(),
                          value: '$_selectedValue',
                          onChanged: (value) {
                            setState(() {
                              _selectedValue = value as String;
                              print(_selectedValue);
                            });
                          },
                          buttonHeight: 40,
                          buttonWidth: 180,
                          itemHeight: 40,
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
                        onPressed: () {
                          //salvar
                          _salvarAtulizarproduto(produtoSelecionada: produto);

                          Navigator.pop(context);
                        },
                        child: Text(textoSalvarAtualizar)
                    )
                  ],
                );
              },
          );
        }
    );
  }

  _recuperarProduto() async {

    //_produtos.clear();
    List produtoRecuperadas = await _db.recuperarproduto();
    //print("Lista produtoes: " + produtoRecuperadas.toString());

    List<Produto>? listaTemporaria = <Produto>[];

    for( var item in produtoRecuperadas){
      Produto produto = Produto.fromMap(item);
      listaTemporaria.add(produto);
    }

    setState(() {
       _produtos = listaTemporaria!;
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
        print(_quantidade);

      }
    }
  }

  _salvarAtulizarproduto( { Produto? produtoSelecionada}) async {

    String nome_produto = _nome_produtoController.text;
    String quantidade = _quantidadeController.text;

    if( produtoSelecionada == null){ // salvar
      //print("data atual: " + DateTime.now().toString() );
      Produto produto = Produto(nome_produto, quantidade, DateTime.now().toString() );
      int resultado = await _db.salvarProduto( produto );
      _recuperarProdutoAcabando();
      //print("salvar produto: " + resultado.toString() );

    }else{ //atualizar
      produtoSelecionada.nome_produto = nome_produto;
      produtoSelecionada.quantidade = quantidade;
      produtoSelecionada.data = DateTime.now().toString() ;
      int resultado = await _db.atualizarproduto(produtoSelecionada);
      _recuperarProdutoAcabando();
    }

    _nome_produtoController.clear();
    _quantidadeController.clear();

    _recuperarProduto();

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
  int quantidadeRemovida = await _db.removerproduto(id!);

  if(quantidadeRemovida >0){
    // remover algum
    _recuperarProduto();
  }

  }

  @override
  void initState(){
    _recuperarFornenedor();
    _recuperarProdutoAcabando();
    _recuperarProduto();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    _recuperarProduto();

    return Scaffold(
      appBar: Cabecalho.cabecalho("Produtos",context, _quantidade),
      body: Column(
        children: <Widget>[
          Expanded(
              child: ListView.builder(
                  itemCount: _produtos.length,
                  itemBuilder: (context, index){

                    final item = _produtos[index];

                    return Card(
                      child: ListTile(
                        title: Text( item.nome_produto.toString() ),
                        subtitle:Text("quantidade: ${item.quantidade} - Data cadastro: ${_formatarData(item.data.toString())}") ,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min ,
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){
                                _exibirTelaCadastro(produto: item);
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
                                        title: Text("Deseja mesmo Excluir esse produto?"),
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
