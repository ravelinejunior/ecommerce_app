import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  //para usuario atual
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;

  //metodo estatico para acesso a classe
  static UserModel of(BuildContext context) =>
      ScopedModel.of<UserModel>(context);
//conterá os dados do usuario
  Map<String, dynamic> userData = Map();

//para verificar se dados estão carregando
  bool isLoading = false;

//chamado quando app é inicializado
  @override
  void addListener(listener) async {
    super.addListener(listener);
    //carregar dados do usuario
    await _loadCurrentUser();
  }

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

  void signIn(
      {@required String email,
      @required String pass,
      @required VoidCallback onSucess,
      @required VoidCallback onFailure}) async {
    isLoading = true;
    //notificar o Flutter que houve uma alteração
    notifyListeners();

    _auth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((authResult) async {
      firebaseUser = authResult.user;

//carregar dados do usuario
      await _loadCurrentUser();

      onSucess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      onFailure();
      isLoading = false;
      notifyListeners();
    });
  }

//recuperar senha
  void recoverPass(String email) {
    _auth.sendPasswordResetEmail(email: email);
  }

  bool isLoggedIn() {
    return firebaseUser != null;
  }

  //função para salvar usuario
  Future<Null> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await Firestore.instance
        .collection("Users")
        .document(firebaseUser.uid)
        .setData(userData);
  }

  //função signOut
  void signOut() async {
    await _auth.signOut();

//dados usuario receber um mapa vazio
    userData = Map();
    firebaseUser = null;
    notifyListeners();
  }

  //carregar dados usuario
  Future<Null> _loadCurrentUser() async {
    //verificar se usuario está vazio
    if (firebaseUser == null) firebaseUser = await _auth.currentUser();

    if (firebaseUser != null) {
      if (userData['name'] == null) {
        //recuperar os itens do documento do usuario logado
        DocumentSnapshot docUser = await Firestore.instance
            .collection("Users")
            .document(firebaseUser.uid)
            .get();

        userData = docUser.data;
      }
    }
    notifyListeners();
  }
}
