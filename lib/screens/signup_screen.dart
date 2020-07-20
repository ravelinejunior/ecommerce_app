import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
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
          "Criar conta",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      //FORMULARIO WIDGET
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(),
            ),
            SizedBox(height: 20.0),
            //NOME
            TextFormField(
              decoration: InputDecoration(
                hintText: "Nome completo",
                fillColor: Colors.black45,
                icon: Icon(
                  Icons.person,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              validator: (text) {
                //CONDIÇÃO PARA VERIFICAR SE CAMPO NOME É VAZIO
                if (text.isEmpty) return "Nome inválido";
              },
            ),
            SizedBox(height: 16.0),
            //ENDEREÇO
            TextFormField(
              decoration: InputDecoration(
                hintText: "Endereço",
                fillColor: Colors.black45,
                icon: Icon(
                  Icons.home,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              validator: (text) {
                //CONDIÇÃO PARA VERIFICAR SE CAMPO NOME É VAZIO
                if (text.isEmpty) return "Endereço inválido";
              },
            ),
            SizedBox(height: 16.0),
            //EMAIL
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
              },
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
                  "Cadastrar",
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
