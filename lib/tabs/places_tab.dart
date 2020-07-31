import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/tiles/place_tile.dart';
import 'package:flutter/material.dart';

class PlacesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection("Places").getDocuments(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          );
        //se tiver dados, retornar a lista de places
        else
          return ListView(
            children:
                snapshot.data.documents.map((doc) => PlaceTile(doc)).toList(),
          );
      },
    );
  }
}
