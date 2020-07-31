import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceTile extends StatelessWidget {
  final DocumentSnapshot snapshot;
  PlaceTile(this.snapshot);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          //IMAGEM widget
          SizedBox(
            height: 200.0,
            child: Image.network(snapshot.data['image'], fit: BoxFit.cover),
          ),

          //ENDEREÇO e titulo
          Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  snapshot.data['title'],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  textAlign: TextAlign.start,
                ),
                Text(
                  snapshot.data['address'],
                  style: TextStyle(fontSize: 16.0),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),

          //mapa e telefone
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton.icon(
                  onPressed: () {
                    launch(
                        "https://www.google.com/maps/search/?api=1&query=${snapshot.data['lat']},${snapshot.data['long']}");
                  },
                  splashColor: Colors.redAccent,
                  icon: Icon(Icons.location_on, color: Colors.blue),
                  label: Text(
                    "Ver no mapa",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                FlatButton.icon(
                  onPressed: () {
                    launch("tel: ${snapshot.data["phone"]}");
                  },
                  splashColor: Colors.lightBlueAccent,
                  icon: Icon(Icons.phone, color: Colors.blue),
                  label: Text(
                    "Ligar",
                    style: TextStyle(color: Colors.blue),
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
