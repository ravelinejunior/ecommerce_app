import 'package:ecommerce_app/model/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CartPrice extends StatelessWidget {
  //para passar esses valores de compra para tela de cartScreen
  final VoidCallback buy;
  CartPrice(this.buy);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      borderOnForeground: true,
      elevation: 1.0,
      child: Container(
        padding: EdgeInsets.all(16.0),
        //como os dados irão variar devido aos produtos, usar scopedmodel
        child: ScopedModelDescendant<CartModel>(
          builder: (context, child, model) {
            //variaveis de calculo final de produto
            double price = model.getProductsPrice();
            double discount = model.getDiscountPrice();
            double ship = model.getShipPrice();
            double total = price - discount + ship;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "Resumo do pedido",
                  style: TextStyle(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 12.0),
                //LINHA DE ELEMENTOS
                Row(
                  //para espaçar igualmente entre as telas
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("SubTotal"),
                    Text("R\$ ${price.toStringAsFixed(2)}"),
                  ],
                ),
                Divider(),
                //LINHA DE ELEMENTOS
                Row(
                  //para espaçar igualmente entre as telas
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Frete"),
                    Text("R\$ ${ship.toStringAsFixed(2)}"),
                  ],
                ),
                Divider(),
                //LINHA DE ELEMENTOS
                Row(
                  //para espaçar igualmente entre as telas
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Desconto"),
                    Text(discount > 1
                        ? "R\$ -${discount.toStringAsFixed(2)}"
                        : "R\$ ${discount.toStringAsFixed(2)}"),
                  ],
                ),
                Divider(),
                SizedBox(height: 12),
                //LINHA DE ELEMENTOS
                Row(
                  //para espaçar igualmente entre as telas
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Total",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    Text(
                      "R\$ ${total.toStringAsFixed(2)}",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Divider(),
                SizedBox(height: 16.0),
                //WIDGET BOTAO COMPRA
                RaisedButton(
                  elevation: 5,
                  onPressed: buy,
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  child: Text("Finalizar Compra"),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
