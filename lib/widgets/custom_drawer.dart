import 'package:ecommerce_app/tiles/drawer_tile.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//função de estilização de gradiente de pagina principal
    Widget _buildDrawerBack() => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 229, 57, 53),
                Color.fromARGB(255, 239, 83, 80),
                Color.fromARGB(255, 239, 154, 154),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        );

    return Drawer(
      //retornar stack por causa do fundo degrade
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16.0),
            children: <Widget>[
              //header do drawer
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 170.0,
                child: Stack(
                  // é melhor para posicionar os itens
                  children: <Widget>[
                    //posicionar
                    Positioned(
                      top: 8.0,
                      left: 0.0,
                      child: Text(
                        "GabiX Moda \nÍntima Femininx",
                        style: TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: Colors.black),
                      ),
                    ),

                    Positioned(
                      left: 0.0,
                      bottom: 0.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //pois será texto sobre texto
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 8.0, top: 10.0),
                            child: Text(
                              "Olá,",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0),
                            ),
                          ),
                          GestureDetector(
                            child: Text(
                              "Entre ou cadastre-se :))",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.white,
              ),
              DrawerTile(Icons.home, "Home"),
              DrawerTile(Icons.category, "Categorias"),
              DrawerTile(Icons.list, "Produtos"),
              DrawerTile(Icons.location_on, "Lojas"),
              DrawerTile(Icons.featured_play_list, "Meus pedidos"),
            ],
          ),
        ],
      ),
    );
  }
}
