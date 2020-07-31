import 'package:ecommerce_app/model/user_model.dart';
import 'package:ecommerce_app/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //chave global dos campos de validação
  final _formKey = GlobalKey<FormState>();

  //controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

//chave global para scafold
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      //APPBAR WIDGET
      appBar: AppBar(
        backgroundColor: Colors.pink[200],
        title: Text(
          "Login",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => SignUpScreen()),
              );
            },
            child: Text(
              "Criar conta",
              style: TextStyle(fontSize: 15.0, color: Colors.white),
            ),
          ),
        ],
      ),

      //FORMULARIO WIDGET (para recuperar dados do modelo usuario)
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          //verificar se dados estão carregando
          if (model.isLoading)
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
              ),
            );
          else
            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: <Widget>[
                  //EMAIL
                  TextFormField(
                    decoration: InputDecoration(),
                  ),
                  SizedBox(height: 32.0),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: "Email",
                      fillColor: Colors.black45,
                      icon: Icon(
                        Icons.alternate_email,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      //CONDIÇÃO PARA VERIFICAR SE CAMPO EMAIL É VAZIO
                      if (text.isEmpty || !text.contains("@"))
                        return "Email inválido";
                      else
                        return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  //SENHA
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: "Senha",
                      icon: Icon(
                        Icons.all_inclusive,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    //para deixar em formato password
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (password) {
                      //CONDIÇÃO PARA VERIFICAR SE CAMPO EMAIL É VAZIO
                      if (password.isEmpty || password.length < 6)
                        return "Senha inválida";
                      else
                        return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  //BOTAO ESQUECER SENHA WIDGET
                  Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      onPressed: () {
                        //verificar se email está vazio
                        if (_emailController.text.isEmpty)
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text(
                                "Insira seu email para recuperar senha",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold)),
                            backgroundColor: Colors.black,
                            duration: Duration(seconds: 3),
                          ));
                        else {
                          //recuperar email
                          model.recoverPass(_emailController.text);
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text("Confira seu email",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14.0)),
                            backgroundColor: Theme.of(context).primaryColor,
                            duration: Duration(seconds: 3),
                          ));
                        }
                      },
                      child: Text(
                        "Esqueci minha senha",
                        textAlign: TextAlign.right,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  //LOGAR WIDGET
                  SizedBox(
                    height: 44,
                    child: RaisedButton(
                      splashColor: Theme.of(context).primaryColor,
                      elevation: 5,
                      onPressed: () {
                        //validando os campos do formulario
                        if (_formKey.currentState.validate()) {}
                        //invocar model sign in
                        model.signIn(
                          email: _emailController.text,
                          pass: _passwordController.text,
                          onSucess: _onSucess,
                          onFailure: _onFailure,
                        );
                      },
                      textColor: Colors.white,
                      color: Colors.pink,
                      child: Text(
                        "Entrar",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            );
        },
      ),
    );
  }

  void _onSucess() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text("Acesso permitido.",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.greenAccent,
      ),
    );

    Navigator.of(context).pop();
  }

  void _onFailure() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: Colors.white,
      content: Text("Verifique sua senha e email",
          style: TextStyle(
              color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16.0)),
      duration: Duration(seconds: 3),
    ));
  }
}
