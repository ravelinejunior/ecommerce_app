import 'package:flutter/material.dart';

class CepCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: true,
      elevation: 1,
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      //ABRE UM SUBMENU
      child: ExpansionTile(
        title: Text(
          "Calculo de frete",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        leading: Icon(Icons.location_on),
        trailing: Icon(Icons.add),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    hintText: "Digite seu CEP"),
                onFieldSubmitted: (value) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Função ainda não implementada!"),
                    backgroundColor: Colors.redAccent,
                    duration: Duration(seconds: 3),
                  ));
                }),
          ),
        ],
      ),
    );
  }
}
