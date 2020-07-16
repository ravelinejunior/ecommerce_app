import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //função de estilização de gradiente de pagina principal
    Widget _buildBodyBack() => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 211, 118, 130),
                Color.fromARGB(255, 253, 181, 168),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        );

    //colocar conteudo acima do fundo
    return Stack(
      children: <Widget>[
        _buildBodyBack(),
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text("Novidades"),
                centerTitle: true,
              ),
            ),
            FutureBuilder<QuerySnapshot>(
              future: Firestore.instance
                  .collection("Images")
                  .orderBy("pos")
                  .getDocuments(),

              // o builder criar a interface
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  //caso ainda esteja carregando os dados
                  return SliverToBoxAdapter(
                    child: Container(
                      height: 200.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  );
                } else {
                  //caso exista dado
                  return SliverStaggeredGrid.count(
                      crossAxisCount: 2, //verifica numero de colunas
                      mainAxisSpacing: 1.0, //espaçamento vertical
                      crossAxisSpacing: 1.0, //espaçamento horizontal
                      //mapear a função para pegar o x e y de cada documento
                      staggeredTiles: snapshot.data.documents.map(
                        (doc) {
                          return StaggeredTile.count(
                              doc.data['x'], doc.data['y']);
                        },
                      ).toList(),
                      children: snapshot.data.documents.map(
                        (doc) {
                          //passar uma array de imagens do snapshot
                          return FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: doc.data['image'],
                            fit: BoxFit.cover,
                          );
                        },
                      ).toList());
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
