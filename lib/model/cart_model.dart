import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/datas/cart_product.dart';
import 'package:ecommerce_app/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  //obter usuario atual
  UserModel userModel;
  List<CartProduct> listProducts = [];

  //CODIGO DO CUPOM DE DESCONTO
  String cupomCode;

  //PORCENTAGEM DO CUPOM
  int cupomPercentage = 0;

  CartModel(this.userModel) {
    if (userModel.isLoggedIn()) _loadCartItems();
  }

  bool isLoading = false;

  //cupom de desconto
  void setCoupom(String cupomCode, int discountPercentage) {
    this.cupomCode = cupomCode;
    this.cupomPercentage = discountPercentage;
  }

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

    Intl.defaultLocale = 'pt_BR';

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
    var dDay = new DateTime.utc(1944, 6, 6);
    var now = new DateTime.now();
    var berlinWallFell = new DateTime.utc(1989, 11, 9);
    var moonLanding = DateTime.parse("1969-07-20 20:18:04Z");
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

    print(dDay);
    print("Now" + now.toString());
    print(berlinWallFell);
    print(moonLanding);

    notifyListeners();
  }

  //função de retorno de valores de produtos
  double getProductsPrice() {
    double price = 0.0;
    for (CartProduct c in listProducts) {
      if (c.productData != null) {
        price += c.quantity * c.productData.price;
      }
    }
    return price;
  }

  //função de retorno de valores de desconto
  double getDiscountPrice() {
    return getProductsPrice() * cupomPercentage / 100;
  }

  //função de retorno de valores de frete
  double getShipPrice() {
    return 9.99;
  }

//função de autalização dos preços
  void updatePrice() {
    notifyListeners();
  }

  // função de finalização de pedidos
  Future<String> finishOrders() async {
    //para ter certeza de que a lista não está vazia
    if (listProducts.length == 0) return null;

    isLoading = true;
    notifyListeners();

    double productsPrice = getProductsPrice();
    double shipPrice = getShipPrice();
    double discount = getDiscountPrice();
    double total = productsPrice - discount + shipPrice;

    //criar as instancias no firebase e add em forma de mapa
    //para recuperar o id do documento criado, utilizar documentref
    DocumentReference refOrder =
        await Firestore.instance.collection("Orders").add(
      {
        'clientId': userModel.firebaseUser.uid,
        //mapear os produtos
        'products':
            listProducts.map((cartProduct) => cartProduct.toMap()).toList(),
        'shipPrice': productsPrice,
        'discount': discount,
        'totalPrice': total,
        'status': 1
      },
    );

    //colocar o id do documento no usuario que o selecionou
    await Firestore.instance
        .collection("Users")
        .document(userModel.firebaseUser.uid)
        .collection("orders")
        .document(refOrder.documentID)
        .setData(
      {'orderId': refOrder.documentID},
    );

    //remover todos os itens do carrinho, tanto na lista quanto no firebase
    QuerySnapshot query = await Firestore.instance
        .collection("Users")
        .document(userModel.firebaseUser.uid)
        .collection("cart")
        .getDocuments();

    //para cada DocumentSnapshot
    for (DocumentSnapshot doc in query.documents) {
      doc.reference.delete();
    }

    //limpar lista
    listProducts.clear();

    cupomCode = null;
    cupomPercentage = 0;

    isLoading = false;
    notifyListeners();

    return refOrder.documentID;
  }
}
