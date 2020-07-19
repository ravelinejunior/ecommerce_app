import 'package:ecommerce_app/datas/product_data.dart';
import 'package:ecommerce_app/screens/product_screen.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  //construtor que recebe os dados e o tipo
  final String tipo;
  final ProductData productData;
  ProductTile(this.tipo, this.productData);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductScreen(productData)));
      },
      child: Card(
        //verificar tipo de estrutura de layout
        child: tipo == "grid"
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  //fixar tamanho da imagem
                  AspectRatio(
                    aspectRatio: 0.8,
                    child: Image.network(
                      productData.images[0],
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                  //TEXTOS
                  Expanded(
                    child: Container(
                      // para dar um espaço entre texto e image
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            productData.title,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "R\$ ${productData.price.toStringAsFixed(2)}",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            //se lista
            : Row(
                children: <Widget>[
                  //flexible para diferentes tipos de tela
                  Flexible(
                    child: Image.network(
                      productData.images[0],
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                      height: 250.0,
                    ),
                    flex: 1,
                  ),
                  Flexible(
                    child: Expanded(
                      child: Container(
                        // para dar um espaço entre texto e image
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              productData.title,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "R\$ ${productData.price.toStringAsFixed(2)}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    flex: 1,
                  )
                ],
              ),
      ),
    );
  }
}
