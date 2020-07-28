import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/model/cart_model.dart';
import 'package:flutter/material.dart';

class DiscountCart extends StatefulWidget {
  @override
  _DiscountCartState createState() => _DiscountCartState();
}

class _DiscountCartState extends State<DiscountCart> {
  TextEditingController discountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0,
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      //ABRE UM SUBMENU
      child: ExpansionTile(
        title: Text(
          "Cupom de desconto",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        leading: Icon(Icons.card_giftcard),
        trailing: Icon(Icons.add),
        //corpo do expansion
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            //Edit WIDGET
            child: TextFormField(
              controller: discountController ?? "",
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: "Digite seu cupom"),
              /*     initialValue:
                  //caso seja nulo
                  CartModel.of(context).cupomCode ?? "", */
              onFieldSubmitted: (text) {
                if (text == null || text.isEmpty) {
                  //aplicar cupom de desconto
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text("Campo de desconto vazio. Digite seu cupom!"),
                      backgroundColor: Colors.redAccent,
                      duration: Duration(seconds: 3),
                    ),
                  );
                }
                //VALIDAR CUPONS NO FIREBASE verificando texto passado
                Firestore.instance
                    .collection("Cupons")
                    .document(text)
                    .get()
                    .then((docSnap) {
                  //verificar se encontrou documento
                  if (docSnap.data != null) {
                    //aplicar cupom de desconto
                    CartModel.of(context)
                        .setCoupom(text, docSnap.data['percent']);
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            "Desconto de ${docSnap.data['percent']}% aplicado."),
                        backgroundColor: Theme.of(context).primaryColor,
                        duration: Duration(seconds: 3),
                      ),
                    );
                  } else {
                    CartModel.of(context).setCoupom(null, 0);
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Cupom não existe."),
                        backgroundColor: Colors.redAccent,
                        duration: Duration(seconds: 3),
                      ),
                    );
                  }
                });
              },
            ),
          ),
          SizedBox(
            height: 16,
          ),
          SizedBox(
            width: 200.0,
            height: 48.0,
            child: RaisedButton.icon(
              onPressed: () {
                if (discountController.text == null ||
                    discountController.text.isEmpty) {
                  //aplicar cupom de desconto
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text("Campo de desconto vazio. Digite seu cupom!"),
                      backgroundColor: Colors.redAccent,
                      duration: Duration(seconds: 3),
                    ),
                  );
                }
                //VALIDAR CUPONS NO FIREBASE verificando texto passado
                Firestore.instance
                    .collection("Cupons")
                    .document(discountController.text)
                    .get()
                    .then((docSnap) {
                  //verificar se encontrou documento
                  if (docSnap.data != null) {
                    //aplicar cupom de desconto
                    CartModel.of(context).setCoupom(
                        discountController.text, docSnap.data['percent']);
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            "Desconto de ${docSnap.data['percent']}% aplicado."),
                        backgroundColor: Theme.of(context).primaryColor,
                        duration: Duration(seconds: 3),
                      ),
                    );
                  } else {
                    CartModel.of(context).setCoupom(null, 0);
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Cupom não existe."),
                        backgroundColor: Colors.redAccent,
                        duration: Duration(seconds: 3),
                      ),
                    );
                  }
                });
              },
              icon: Icon(Icons.attach_money),
              label: Text("Aplicar desconto"),
              color: Colors.blue,
              textColor: Colors.white,
              splashColor: Theme.of(context).primaryColor,
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }
}
