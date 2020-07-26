import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/datas/cart_product.dart';
import 'package:ecommerce_app/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  //obter usuario atual
  UserModel userModel;
  List<CartProduct> listProducts = [];

  CartModel(this.userModel) {
    if (userModel.isLoggedIn()) _loadCartItems();
  }

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

  //função para remover item
  void decProduct(CartProduct cartProduct) {
    cartProduct.quantity--;
    Firestore.instance
        .collection("Users")
        .document(userModel.firebaseUser.uid)
        .collection("cart")
        .document(cartProduct.idCart)
        .updateData(cartProduct.toMap());

//adicionar na tela
    notifyListeners();
  }

  //função para adicionar item
  void incProduct(CartProduct cartProduct) {
    cartProduct.quantity++;
    Firestore.instance
        .collection("Users")
        .document(userModel.firebaseUser.uid)
        .collection("cart")
        .document(cartProduct.idCart)
        .updateData(cartProduct.toMap());

    notifyListeners();
  }

  //carregar todos os itens na tela
  void _loadCartItems() async {
    //recuperar todos os documentos
    QuerySnapshot querySnapshot = await Firestore.instance
        .collection("Users")
        .document(userModel.firebaseUser.uid)
        .collection("cart")
        .getDocuments();

//retornar uma lista com todos os documentos vinda da query
    listProducts = querySnapshot.documents
        .map((doc) => CartProduct.fromDocument(doc))
        .toList();

    notifyListeners();
  }
}
