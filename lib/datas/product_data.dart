import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  String id;
  String title;
  String description;
  double price;
  List sizes;
  List images;
  String category;

  /*construtor que recebe os dados do firebase
  basicamente é um tipo de conversor de dados do tipo snapshot para esse model
  */
  ProductData.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.documentID;
    title = snapshot.data['title'];
    description = snapshot.data['description'];
    price = snapshot.data['price'] + 0.0; // para caso valores inteiros
    sizes = snapshot.data['sizes'];
    images = snapshot.data['images'];
  }

//pegar o "resumo dos dados selecionados no carrinho"
  Map<String, dynamic> toResumedMap() {
    return {'title': title, 'description': description, 'price': price};
  }
}
