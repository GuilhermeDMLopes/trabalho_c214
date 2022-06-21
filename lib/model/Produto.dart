
class Produto{

  int? id;
  String? nome_produto;
  String? quantidade;
  String? data;

  Produto(this.nome_produto, this.quantidade, this.data);

  Produto.fromMap(Map map){
    this.id = map["id"];
    this.nome_produto = map["nome_produto"];
    this.quantidade = map["quantidade"];
    this.data = map["data"];

  }

  Map toMap(){

    Map<String, dynamic> map = {
      "nome_produto" : this.nome_produto,
      "quantidade" : this.quantidade,
      "data" : this.data,
    };

    if( this.id != null ){
      map["id"] = this.id;
    }

    return map;

  }

}