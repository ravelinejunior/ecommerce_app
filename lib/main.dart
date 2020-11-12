import 'package:ecommerce_app/model/cart_model.dart';
import 'package:ecommerce_app/model/user_model.dart';
import 'package:ecommerce_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //para que modelo usuario seja pego em todo app
    return ScopedModel<UserModel>(
      //caso haja uma alteração de um modelo em uma tela, mudará em todas
      model: UserModel(),
      //colocar scoped model dos produtos abaixo do usermodel pois carrinho de produtos precisa de acesso ao usuario
      child: ScopedModelDescendant<UserModel>(
        // para recriar toda vez que logar com outro usuario
        builder: (context, child, model) {
          return ScopedModel<CartModel>(
            model: CartModel(model),
            child: MaterialApp(
              title: 'Loja virtual',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                primaryColor: Color.fromARGB(255, 4, 125, 141),
              ),
              home: HomeScreen(),
              debugShowCheckedModeBanner: false,
              debugShowMaterialGrid: false,
            ),
          );
        },
      ),
    );
  }
}
