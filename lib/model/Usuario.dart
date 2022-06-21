
class Usuario{

  int? id;
  String? email_usuario;
  String? senha;

  Usuario(this.email_usuario, this.senha);

  Usuario.fromMap(Map map){
    this.id = map["id"];
    this.email_usuario = map["email_usuario"];
    this.senha = map["senha"];
  }

  Map toMap(){

    Map<String, dynamic> map = {
      "email_usuario" : this.email_usuario,
      "senha" : this.senha,
    };

    if( this.id != null ){
      map["id"] = this.id;
    }
    return map;
  }
}