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
                //variavel de status
                int status = snapshot.data['status'];

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
                    SizedBox(height: 8.0),
                    Text(
                      "Status do pedido",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4.0),
                    //BOLINHA DE STAT
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        _buildCircle("1", "Confirmação", status, 1),
                        _separationLine(),
                        _buildCircle("2", "Transporte", status, 2),
                        _separationLine(),
                        _buildCircle("3", "Entregue", status, 3),
                      ],
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

    text += "Total: R\$ ${snapshot.data["totalPrice"].toStringAsFixed(2)}\n";
    //#TODO adicionar uma data
    return text;
  }

  //bolinhas de configuração WIDGET
  Widget _buildCircle(
      String title, String subtitle, int status, int thisStatus) {
    //this status é o status da bolinha (1.2.3)
    //chamar 3x abaixo da coluna
    Color backColor;
    Widget child;

    //1- ainda aguardando preparação para exibir em cinza as que nao foram ativadas
    if (status < thisStatus) {
      backColor = Colors.grey[500];
      child = Text(title, style: TextStyle(color: Colors.white));
    } // 2- caso ambos os status ja foram processados ai a bolinha é azul e circulo gira
    else if (status == thisStatus) {
      backColor = Colors.blue;
      child = Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Text(title, style: TextStyle(color: Colors.white)),
          CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
        ],
      );
    } //caso status tenha sido processado
    else {
      backColor = Colors.green;
      child = Icon(Icons.check, color: Colors.white);
    }

    //retornar os valores
    return Column(
      children: <Widget>[
        CircleAvatar(
          //passar os widgets criados acima no circle avatar
          radius: 20.0,
          backgroundColor: backColor,
          child: child,
        ),

        //subtitulo WIDGET
        Text(subtitle)
      ],
    );
  }

  //widget linha de separação
  Widget _separationLine() {
    return Container(
      height: 1.0,
      width: 40.0,
      color: Colors.grey[500],
    );
  }
}
