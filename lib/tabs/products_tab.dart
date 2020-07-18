import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/tiles/category_tile.dart';
import 'package:flutter/material.dart';

class ProductsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection("Produtos").getDocuments(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
            ),
          );
        else {
          //criar divisor entre itens
          var itemDivider = ListTile.divideTiles(
            tiles: snapshot.data.documents.map(
              (document) {
                return CategoryTile(document);
              },
            ).toList(),
            color: Colors.grey[500],
          ).toList();
          //criar a lista de categorias caso haja dados a serem retornados
          return ListView(
            //mapear objetos no firebase para recuperar dados e setar como lista
            children: itemDivider,
          );
        }
      },
    );
  }
}
