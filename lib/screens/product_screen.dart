import 'package:carousel_pro/carousel_pro.dart';
import 'package:ecommerce_app/datas/product_data.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
//construtor com dados do objeto selecionado
  final ProductData productData;
  ProductScreen(this.productData);

  @override
  _ProductScreenState createState() => _ProductScreenState(productData);
}

class _ProductScreenState extends State<ProductScreen> {
  //para recuperar valor de construtor em uma var, declarar um construtor
  final ProductData product;
  _ProductScreenState(this.product);

  final Color corTheme = Colors.redAccent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.title,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: corTheme,
      ),
      //como usuario poderá deslizar na tela, usar listView
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.9,
            child: Carousel(
              //transformar urls em maps e depois em lista
              images: product.images.map((url) {
                return NetworkImage(url);
              }).toList(),
              dotSize: 4.0,
              dotSpacing: 15.0,
              dotBgColor: Colors.pinkAccent,
              dotColor: corTheme,
              autoplay: true,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  product.title,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                  maxLines: 3,
                ),
                Text(
                  "R\$ ${product.price.toStringAsFixed(2)}",
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: corTheme),
                  maxLines: 3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
