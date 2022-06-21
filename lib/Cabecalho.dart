
import 'package:controle_estoque_c317_flutter/DAO/DatabaseHelper.dart';
import 'package:controle_estoque_c317_flutter/model/Produto.dart';
import 'package:controle_estoque_c317_flutter/telas/TelaLogin.dart';
import 'package:controle_estoque_c317_flutter/telas/TelaPrincipal.dart';
import 'package:badges/badges.dart';
import 'package:controle_estoque_c317_flutter/telas/TelaProdutosAcabando.dart';
import 'package:flutter/material.dart';

class Cabecalho {

  static AppBar cabecalho(String testo, BuildContext context,int acabando)  {

    return AppBar(
      toolbarHeight: 60,
      backgroundColor: Colors.green,
      centerTitle: true,
      title: Text(testo),
      leading: IconButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TelaPrincipal()));
        },
        icon: Icon(Icons.home),
      ),
      actions: [
        Badge(
          toAnimate: true,
          animationType: BadgeAnimationType.scale,
          // ignore: argument_type_not_assignable

          badgeContent: Text("$acabando"), //Text(await _recuperarProduto, style: TextStyle(color: Colors.white)),
          child: IconButton(
            icon: Icon(Icons.notification_add),
            onPressed: () {Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TelaProdutoAcabando()));},
          ),
          position: BadgePosition.topEnd(top: 12, end: 4),

        ),
        IconButton(
          icon: Icon(Icons.logout_sharp),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Deseja mesmo Deslogar?"),
                    actions: <Widget>[
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("Nao")
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TelaLogin()));
                          },
                          child: Text("Sim")
                      )
                    ],
                  );
                }
            );
          }
        ),
      ]
    );
  }
}