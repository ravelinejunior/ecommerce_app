import 'package:ecommerce_app/model/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CartSreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[300],
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
    );
  }
}
