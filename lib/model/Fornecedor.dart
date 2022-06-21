
class Fornecedor{

  int? id;
  String? nome_fornecedor;
  String? local;
  String? data;

  Fornecedor(this.nome_fornecedor, this.local, this.data);

  Fornecedor.fromMap(Map map){
    this.id = map["id"];
    this.nome_fornecedor = map["nome_fornecedor"];
    this.local = map["local"];
    this.data = map["data"];

  }

  Map toMap(){

    Map<String, dynamic> map = {
      "nome_fornecedor" : this.nome_fornecedor,
      "local" : this.local,
      "data" : this.data,
    };

    if( this.id != null ){
      map["id"] = this.id;
    }

    return map;

  }

}