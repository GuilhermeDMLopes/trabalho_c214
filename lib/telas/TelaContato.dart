
import 'package:controle_estoque_c317_flutter/Cabecalho.dart';
import 'package:controle_estoque_c317_flutter/DAO/DatabaseHelper.dart';
import 'package:controle_estoque_c317_flutter/model/Produto.dart';
import 'package:flutter/material.dart';

class TelaContato extends StatefulWidget {
  const TelaContato({Key? key}) : super(key: key);

  @override
  State<TelaContato> createState() => _TelaContatoState();
}

class _TelaContatoState extends State<TelaContato> {

  var _quantidade = 0;
  var _db = DatabaseHelper();

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
  @override
  void initState(){
    _recuperarProdutoAcabando();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Cabecalho.cabecalho("Contato",context,_quantidade),
      body: SingleChildScrollView( // para ter a opcao de rolagem no app
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget> [
                  Image.asset("images/detalhe_contato.png"),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                        "Contato",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black
                        )
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top:16),
                child: Text(
                    "atendimento@roizSystem.com.br"
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top:16),
                child: Text(
                    "Telefone: (35) 99875-1112"
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top:16),
                child: Text(
                    "Celular: (35) 9957-5454"
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
