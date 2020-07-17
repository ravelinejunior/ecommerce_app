import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
//para criar o tile, passar icone e texto
  final IconData iconTile;
  final String texteTile;
  final PageController pageController;
  final int page; // enumerador de paginas

  //criar construtor
  DrawerTile(this.iconTile, this.texteTile, this.pageController, this.page);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      // para efeito visual
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
          //navegar entre paginas
          pageController.jumpToPage(page);
        },
        splashColor: Colors.white,
        child: Container(
          height: 60.0,
          child: Row(
            children: <Widget>[
              Icon(iconTile,
                  size: 32.0,
                  color: pageController.page.round() == page
                      ? Colors.white
                      : Colors.black87),
              SizedBox(
                width: 10.0,
              ),
              Text(
                texteTile,
                style: TextStyle(
                    fontSize: 16.0,
                    color: pageController.page.round() == page
                        ? Colors.white
                        : Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
