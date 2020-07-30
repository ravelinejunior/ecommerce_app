import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  //construtor
  final String orderId;
  OrderTile(this.orderId);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        //StreamBuilder para poder modificar tela em TEMPO REAL
        child: StreamBuilder<DocumentSnapshot>(
            // .snapshots para ver alguma alteração
            stream: Firestore.instance
                .collection("Orders")
                .document(orderId)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                    child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
                ));
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Código do pedido: ${snapshot.data.documentID}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4.0),
                    //DESCRIÇÃO WIDGET
                    Text(
                      _buildProductsText(snapshot.data),
                    ),
                  ],
                );
              }
            }),
      ),
    );
  }

  //textos
  String _buildProductsText(DocumentSnapshot snapshot) {
    String text = "Descrição:\n";
    //percorrer pedidos
    for (LinkedHashMap p in snapshot.data['products']) {
      text +=
          "${p['quantity']} x ${p["product"]["title"]} (R\$ ${p["product"]["price"].toStringAsFixed(2)})\n";
    }

    text += "Total: R\$ ${snapshot.data["totalPrice"].toStringAsFixed(2)}";
    return text;
  }
}
