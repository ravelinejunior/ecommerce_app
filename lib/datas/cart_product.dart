//classe que irá armazenar os dados dos produtos
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/datas/product_data.dart';

class CartProduct {
  String idCart;
  String category;
  String idProduct;
  int quantity;
  String size;

  CartProduct();

  ProductData
      productData; // dados do produto dos carrinho para dados temporarios

  //construtor
  CartProduct.fromDocument(DocumentSnapshot document) {
    idCart = document.documentID;
    category = document.data['category'];
    idProduct = document.data['idProduct'];
    quantity = document.data['quantity'];
    size = document.data['size'];
  }

  //transformar dados em mapa para enviar para o firebase
  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'idProduct': idProduct,
      'quantity': quantity,
      'size': size,
      //'product':productData.toResumedMap() // resumo dos dados do produto
    };
  }
}
