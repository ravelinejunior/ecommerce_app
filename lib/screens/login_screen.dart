import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  //chave global dos campos de validação
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      //APPBAR WIDGET
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text(
          "Login",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            onPressed: () {},
            child: Text(
              "Criar conta",
              style: TextStyle(fontSize: 15.0, color: Colors.white),
            ),
          ),
        ],
      ),

      //FORMULARIO WIDGET
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            //EMAIL
            TextFormField(
              decoration: InputDecoration(),
            ),
            SizedBox(height: 20.0),
            TextFormField(
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
                  return text;
              },
            ),
            SizedBox(height: 16.0),
            //SENHA
            TextFormField(
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
                  return password;
              },
            ),
            SizedBox(height: 16.0),
            //BOTAO ESQUECER SENHA WIDGET
            Align(
              alignment: Alignment.centerRight,
              child: FlatButton(
                onPressed: () {},
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
                  if (_formKey.currentState.validate()) {
                  } else {}
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
      ),
    );
  }
}
