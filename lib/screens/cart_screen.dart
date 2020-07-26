import 'package:ecommerce_app/model/cart_model.dart';
import 'package:ecommerce_app/model/user_model.dart';
import 'package:ecommerce_app/screens/login_screen.dart';
import 'package:ecommerce_app/tiles/cart_tile_product.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CartSreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Meu carrinho",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 8.0),
            //alinhar texto do carrinho
            alignment: Alignment.centerRight,
            //declarar tipo de chamada nno scopedmodel
            child: ScopedModelDescendant<CartModel>(
                builder: (context, child, model) {
              int p = model.listProducts.length; // quantidade de produtos
              return Text(
                //retornar nulo ou o valor de p
                "${p ?? 0} ${p == 1 ? "Item" : "Itens"}",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0),
              );
            }),
          ),
        ],
      ),
      //como a tela dependerá do CartModel, setar scopedmodel
      body: ScopedModelDescendant<CartModel>(
        builder: (context, child, model) {
          //tratar os casos
          //1- usuario está logado?
          if (model.isLoading && UserModel.of(context).isLoggedIn()) {
            //barra circular Widget
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.pink[300]),
              ),
            );
          } else if (!UserModel.of(context).isLoggedIn()) {
            return Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.remove_shopping_cart,
                      color: Theme.of(context).primaryColor, size: 80.0),
                  const SizedBox(height: 16.0),
                  Text(
                    "Faça o login para adicionar produtos ao carrinho!",
                    overflow: TextOverflow.fade,
                    style:
                        TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    height: 60.0,
                    child: RaisedButton(
                      splashColor: Colors.blue[400],
                      padding: EdgeInsets.all(16.0),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      elevation: 10.0,
                      child: Text(
                        "Entrar",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          //2- cartmodel está carregando?

          //3- carrinho está vazio?
          else if (model.listProducts == null ||
              model.listProducts.length == 0) {
            return Container(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  "Nenhum produto adicionado no carrinho ainda!",
                  style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          //4- usuario tem os itens no carrinho? crir lista de produtos
          else {
            return ListView(
              children: <Widget>[
                Column(
                  children:
                      //mapear os produtos da lista para poder criar automaticamente
                      model.listProducts.map((product) {
                    return CartTile(product);
                  }).toList(),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
