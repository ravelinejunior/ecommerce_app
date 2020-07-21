import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  //para usuario atual
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;

//conterá os dados do usuario
  Map<String, dynamic> userData = Map();

//para verificar se dados estão carregando
  bool isLoading = false;

//@required para ser obrigatorio
  void signUp(
      {@required Map<String, dynamic> userData,
      @required String pass,
      @required VoidCallback onSucess,
      @required VoidCallback onFailure}) async {
    isLoading = true;
    notifyListeners();

    //criar usuario
    _auth
        .createUserWithEmailAndPassword(
            email: userData['email'], password: pass)
        .then((authResult) async {
      // colocar dados no usuario novo
      firebaseUser = authResult.user;

      //salvar dados complementares do usuario
      await _saveUserData(userData);

      onSucess();
      await Future.delayed(Duration(seconds: 3));
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      onFailure();
      isLoading = false;
      notifyListeners();
    });
  }

  void signIn() async {
    isLoading = true;
    //notificar o Flutter que houve uma alteração
    notifyListeners();
    await Future.delayed(Duration(seconds: 3));

    //após carregar notificar que não está mais carregando
    isLoading = false;
    notifyListeners();
  }

  void recoverPass() {}

  bool isLoggedIn() {
    return false;
  }

  //função para salvar usuario
  Future<Null> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await Firestore.instance
        .collection("Users")
        .document(firebaseUser.uid)
        .setData(userData);
  }
}
