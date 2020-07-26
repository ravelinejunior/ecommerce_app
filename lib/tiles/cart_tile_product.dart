import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/datas/cart_product.dart';
import 'package:ecommerce_app/datas/product_data.dart';
import 'package:ecommerce_app/model/cart_model.dart';
import 'package:flutter/material.dart';

class CartTile extends StatelessWidget {
  //construtor passando um produto
  final CartProduct cartProduct;
  CartTile(this.cartProduct);

  @override
  Widget build(BuildContext context) {
    //WIDGET CONSTRUTOR DOS ITENS
    Widget _buildContent() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          //selecionar container para poder selecionar largura
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            width: 120.0,
            child: Image.network(
              cartProduct.productData.images[0],
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover,
            ),
          ),
          //para cobrir resto da tela
          Expanded(
              child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                //titulo
                Text(
                  cartProduct.productData.title,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                //tamanho
                Text(
                  "Tamanho: ${cartProduct.size}",
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                //preço
                Text(
                  "R\$ ${cartProduct.productData.price.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                //CRIAR TELA DE ADIÇÃO DE QUANTIDADE DE PRODUTOS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    //remover 1  WIDGET
                    IconButton(
                      icon: Icon(
                        Icons.remove,
                        size: 18.0,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: cartProduct.quantity > 1
                          ? () {
                              CartModel.of(context).decProduct(cartProduct);
                            }
                          : null,
                    ),
                    //TEXTO QUANTIDADE WIDGET
                    Text(
                      cartProduct.quantity.toString(),
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //BOTAO MAIS
                    IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Theme.of(context).primaryColor,
                        size: 18.0,
                      ),
                      onPressed: () {
                        CartModel.of(context).incProduct(cartProduct);
                      },
                    ),
                    //BOTAO REMOVER WIDGET
                    FlatButton(
                      child: Text(
                        "Remover",
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                      onPressed: () {
                        CartModel.of(context).removeCartItem(cartProduct);
                      },
                    ),
                  ],
                ),
              ],
            ),
          )),
        ],
      );
    }

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: //verificar se dados do produto ja foram carregados e salvos em cache,
          cartProduct.productData == null
              ? //caso seja nulo, criar
              FutureBuilder<DocumentSnapshot>(
                  future: Firestore.instance
                      .collection("Produtos")
                      .document(cartProduct.category)
                      .collection("items")
                      .document(cartProduct.idProduct)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      //armazenar dados recebidos do firebase no cartProduct
                      cartProduct.productData =
                          ProductData.fromDocument(snapshot.data);
                      return _buildContent();
                    } else {
                      return Container(
                        height: 70.0,
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.pink[300])),
                        alignment: Alignment.center,
                      );
                    }
                  },
                )
              : _buildContent(), // caso dados ja estejam la, apenas mostrar
    );
  }
}
