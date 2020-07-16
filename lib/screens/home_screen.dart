import 'package:ecommerce_app/tabs/home_tab.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final _pageController = PageController(); // pageController
  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: NeverScrollableScrollPhysics(), //impedir rolar pagina
      children: <Widget>[
        HomeTab(),
      ],
    );
  }
}
