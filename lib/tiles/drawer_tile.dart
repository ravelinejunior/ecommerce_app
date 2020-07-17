import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
//para criar o tile, passar icone e texto
  final IconData iconTile;
  final String texteTile;

  //criar construtor
  DrawerTile(this.iconTile, this.texteTile);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      // para efeito visual
      child: InkWell(
        onTap: () {},
        splashColor: Colors.white,
        child: Container(
          height: 60.0,
          child: Row(
            children: <Widget>[
              Icon(
                iconTile,
                size: 32.0,
                color: Colors.black,
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                texteTile,
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
