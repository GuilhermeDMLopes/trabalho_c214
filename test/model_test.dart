import 'package:controle_estoque_c317_flutter/model/Fornecedor.dart';
import 'package:controle_estoque_c317_flutter/model/Produto.dart';
import 'package:controle_estoque_c317_flutter/model/Usuario.dart';
import 'package:flutter/cupertino.dart';
import 'package:test/test.dart';
import 'package:controle_estoque_c317_flutter/DAO/DatabaseHelper.dart';

void main()   {
  test('fornecedorInstancia', ()  {
    WidgetsFlutterBinding.ensureInitialized();
    Fornecedor fornecedor = Fornecedor("Fornecedor Teste", "Sao Paulo", DateTime.now().toString() );


    expect(fornecedor.nome_fornecedor, "Fornecedor Teste");
    expect(fornecedor.local, "Sao Paulo");
  });
  test('fornecedorNotNull', ()  {
    WidgetsFlutterBinding.ensureInitialized();
    Fornecedor fornecedor = Fornecedor("Fornecedor Teste", "Sao Paulo", DateTime.now().toString() );


    expect(fornecedor.nome_fornecedor != null, true);
    expect(fornecedor.local != null, true);

  });
  test('fornecedorLenght', ()  {
    WidgetsFlutterBinding.ensureInitialized();
    Fornecedor fornecedor = Fornecedor("Fornecedor Teste", "Sao Paulo", DateTime.now().toString() );


    expect(fornecedor.nome_fornecedor?.length, 16);
    expect(fornecedor.local?.length, 9);
  });

  test('usuarioInstancia', ()  {
    Usuario usuario = Usuario("rodrigo@gail.com", "123456");
    expect(usuario.email_usuario, "rodrigo@gail.com");
    expect(usuario.senha, "123456");

  });

  test('usuarioNotNull', ()  {
    Usuario usuario = Usuario("rodrigo@gail.com", "123456");
    expect(usuario.email_usuario!= null, true);
    expect(usuario.senha!= null, true);

  });

  test('usuarioLenght', ()  {
    Usuario usuario = Usuario("rodrigo@gail.com", "123456");
    expect(usuario.email_usuario?.length, 16);
    expect(usuario.senha?.length, 6);

  });

  test('produtoInstancia', ()  {
    Fornecedor fornecedor = Fornecedor("Fornecedor Teste", "Sao Paulo",
        DateTime.now().toString() );

    Produto produto = Produto("Coca Cola", "200", DateTime.now().toString(),
        fornecedor.nome_fornecedor);

    expect(produto.nome_produto, "Coca Cola");
    expect(produto.quantidade, "200");
    expect(produto.fornecedor, "Fornecedor Teste");

  });

  test('produtoNotNull', ()  {
    Fornecedor fornecedor = Fornecedor("Fornecedor Teste", "Sao Paulo",
        DateTime.now().toString() );

    Produto produto = Produto("Coca Cola", "200", DateTime.now().toString(),
        fornecedor.nome_fornecedor);

    expect(produto.nome_produto!= null, true);
    expect(produto.quantidade!= null, true);
    expect(produto.fornecedor!= null, true);

  });
  test('produtolenght', ()  {
    Fornecedor fornecedor = Fornecedor("Fornecedor Teste", "Sao Paulo",
        DateTime.now().toString() );

    Produto produto = Produto("Coca Cola", "200", DateTime.now().toString(),
        fornecedor.nome_fornecedor);

    expect(produto.nome_produto?.length, 9);
    expect(produto.quantidade?.length, 3);
    expect(produto.fornecedor?.length, 16);

  });




}