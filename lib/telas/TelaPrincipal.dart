

import 'package:controle_estoque_c317_flutter/Cabecalho.dart';
import 'package:controle_estoque_c317_flutter/DAO/DatabaseHelper.dart';
import 'package:controle_estoque_c317_flutter/model/Produto.dart';
import 'package:controle_estoque_c317_flutter/telas/TelaHelp.dart';
import 'package:controle_estoque_c317_flutter/telas/TelaFornecedor.dart';
import 'package:controle_estoque_c317_flutter/telas/TelaContato.dart';
//import 'package:controle_estoque_c317_flutter/telas/TelaLogin.dart';
//import 'package:controle_estoque_c317_flutter/factory/FactoryConnection.dart';
import 'package:controle_estoque_c317_flutter/telas/TelaProduto.dart';
import 'package:flutter/material.dart';
// 6AB633
class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal( {Key? key}) : super(key: key);

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  var _quantidade = 0;
  var _db = DatabaseHelper();
  void _abrirProduto(){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TelaProduto()));
  }

  void _abrirFornenedor(){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TelaFornecedor()));
  }

  void _abrirContato(){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TelaContato()));
  }

  void _abrirAjuda(){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TelaHelp()));
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

  @override
  void initState(){
//    FactoryConnection.inicializarDB();
    _recuperarProdutoAcabando();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: Cabecalho.cabecalho("Controle de estoque",context,_quantidade),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              Image(image: AssetImage(""
                  "images/logo.png",
              )),
              Padding(
                padding: EdgeInsets.only(top:32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, // alinhar a linha
                  children: <Widget>[
                    GestureDetector(
                      onTap: _abrirProduto , // ao clicar na imagem
                      child: Image.asset(
                        "images/produto.png",
                        width: 140,
                        height: 140,
                      ),
                    ),
                    GestureDetector(
                      onTap: _abrirFornenedor , // ao clicar na imagem
                      child: Image.asset(
                          "images/fornecedor.png",
                           width: 140,
                           height: 140,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top:32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, // alinhar a linha
                  children: <Widget>[
                    GestureDetector(
                      onTap: _abrirAjuda , // ao clicar na imagem
                      child: Image.asset(
                          "images/ajuda.png",
                          width: 140,
                          height: 140,
                      ),
                    ),
                    GestureDetector(
                      onTap: _abrirContato, // ao clicar na imagem
                      child: Image.asset(
                          "images/contatos.png",
                          width: 140,
                          height: 140,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )

    );
  }
}


