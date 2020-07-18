import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/datas/product_data.dart';
import 'package:ecommerce_app/tiles/product_tile.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  //construtor que recebe o snapshot com os dados no firebase
  final DocumentSnapshot snapshot;
  CategoryScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {
    //para adição de tabs
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Text(
            snapshot.data['title'],
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          automaticallyImplyLeading: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            //tabs recebe uma lista de widgets
            tabs: <Widget>[
              Tab(icon: Icon(Icons.grid_on)),
              Tab(icon: Icon(Icons.list)),
            ],
          ),
        ),
        body: //os dados que virão do firebase serão do "futuro"
            //criar o tab bar apenas depois de carregar os dados
            FutureBuilder<QuerySnapshot>(
          //recuperar documentos dos produtos
          future: Firestore.instance
              .collection("Produtos")
              .document(snapshot.documentID)
              .collection("items")
              .getDocuments(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
                ),
              );
            else
              return TabBarView(
                children: [
                  //colocar o grid com o builder para nao carregar tudo de uma vez
                  GridView.builder(
                    padding: EdgeInsets.all(4.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // numero de itens por linha
                        mainAxisSpacing: 4.0,
                        crossAxisSpacing: 4.0,
                        childAspectRatio: 0.65 // altura/largura
                        ),
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (contex, index) {
                      return ProductTile(
                        "grid",
                        ProductData.fromDocument(
                            snapshot.data.documents[index]),
                      );
                    },
                  ),
                  //tipo lista
                  ListView.builder(
                    padding: EdgeInsets.all(4.0),
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (contex, index) {
                      return ProductTile(
                        "list",
                        ProductData.fromDocument(
                            snapshot.data.documents[index]),
                      );
                    },
                  )
                ],
              );
          },
        ),
      ),
    );
  }
}
