import 'dart:ui';

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

  //string para verificar qual tamanho está selecionado
  String size;

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
              dotBgColor: Colors.transparent,
              dotColor: corTheme,
              autoplay: true,
              autoplayDuration: Duration(seconds: 3),
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
                SizedBox(height: 16.0), // margin entre os boxes
                Text(
                  "Tamanhos",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                  maxLines: 3,
                ),
                // margin entre os boxes
                //utilizar a gridview para criar os tamanhos
                SizedBox(
                  height: 34.0,
                  child: GridView(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1, // pois será apenas uma linha de uso
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.5,
                    ),
                    children:
                        //transformar em mapa para pegar valores dos tamanhos
                        product.sizes.map(
                      (sizes) {
                        //CAIXAS DE TAMANHO WIDGETS
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              size = sizes;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4.0),
                              ),
                              border: Border.all(
                                //verificar cor por valor selecionado
                                color:
                                    sizes == size ? corTheme : Colors.grey[500],
                                width: 4.0,
                              ),
                            ),
                            width: 50.0,
                            alignment: Alignment.center,
                            child: Text(sizes),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
                SizedBox(height: 16),
                //BOTAO WIDGET
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    splashColor: Theme.of(context).primaryColor,
                    onPressed:
                        //condição para verificar se o tamanho foi selecionado para poder habilitar o botao
                        size != null ? () {} : null,
                    child: Text(
                      "Adicionar ao carrinho",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    color: Colors.redAccent[400],
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(height: 16),
                //DESCRIÇÃO WIDGET
                Text(
                  "Descrição:",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    product.description,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
