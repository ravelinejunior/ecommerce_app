import 'package:ecommerce_app/tabs/home_tab.dart';
import 'package:ecommerce_app/tabs/products_tab.dart';
import 'package:ecommerce_app/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final _pageController = PageController(); // pageController
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(), //impedir rolar pagina
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Categorias", style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.red[300],
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: ProductsTab(),
        ),
      ],
    );
  }
}
