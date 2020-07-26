import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/datas/cart_product.dart';
import 'package:ecommerce_app/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  //obter usuario atual
  UserModel userModel;
  List<CartProduct> listProducts = [];

  CartModel(this.userModel);

  bool isLoading = false;

  //metodo de acesso estatico a classe
  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  // função para adicionar items
  void addCartItem(CartProduct cartProduct) {
    listProducts.add(cartProduct);
    //adicionar ao banco de dados
    Firestore.instance
        .collection("Users")
        .document(userModel.firebaseUser.uid)
        .collection("cart")
        .add(cartProduct.toMap())
        .then((doc) {
      //salvar o id gerado do product
      cartProduct.idCart = doc.documentID;
    });

    //notificar alteração
    notifyListeners();
  }

  //função para remover item
  void removeCartItem(CartProduct cartProduct) {
    Firestore.instance
        .collection("Users")
        .document(userModel.firebaseUser.uid)
        .collection("cart")
        .document(cartProduct.idCart)
        .delete();

    //remover da lista
    listProducts.remove(cartProduct);
    notifyListeners();
  }
}
