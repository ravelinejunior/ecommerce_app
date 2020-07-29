import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/model/user_model.dart';
import 'package:ecommerce_app/screens/login_screen.dart';
import 'package:ecommerce_app/tiles/order_tile.dart';
import 'package:flutter/material.dart';

class OrdersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //exibir o drawer apenas se usuario estiver logado
    if (UserModel.of(context).isLoggedIn()) {
      //recuperar o id do usuario
      String uid = UserModel.of(context).firebaseUser.uid;

      //carregar todos os pedidos de uma coleção
      return FutureBuilder<QuerySnapshot>(
          future: Firestore.instance
              .collection("Users")
              .document(uid)
              .collection("orders")
              .getDocuments(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
              ));
            } else {
              return ListView(
                //o children sera preenchido atraves de um maps
                children: snapshot.data.documents
                    .map((doc) => OrderTile(doc.documentID))
                    .toList(),
              );
            }
          });
    } else {
      return Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.view_carousel, color: Colors.red, size: 80.0),
            const SizedBox(height: 16.0),
            Text(
              "Faça o login para visualizar seus pedidos.",
              overflow: TextOverflow.fade,
              style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 60.0,
              child: RaisedButton(
                splashColor: Colors.blue[400],
                padding: EdgeInsets.all(16.0),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                color: Colors.redAccent,
                textColor: Colors.white,
                elevation: 10.0,
                child: Text(
                  "Entrar",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
