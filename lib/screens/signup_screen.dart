import 'package:ecommerce_app/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  //controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _enderecoController = TextEditingController();

  void clearControllers() {
    _nameController.text = "";
    _emailController.text = "";
    _passwordController.text = "";
    _enderecoController.text = "";
  }

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
      body: ScopedModelDescendant<UserModel>(builder: (context, child, model) {
        //caso ainda esteja carregando
        if (model.isLoading)
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
            ),
          );
        else
          return Form(
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
                  controller: _nameController,
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
                  controller: _enderecoController,
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
                  },
                ),
                SizedBox(height: 16.0),
                //CADASTRAR WIDGET
                SizedBox(
                  height: 44,
                  child: RaisedButton(
                    splashColor: Theme.of(context).primaryColor,
                    elevation: 5,
                    onPressed: () {
                      //validando os campos do formulario
                      if (_formKey.currentState.validate()) {
                        //recuperar valores dos controllers em formato de mapa
                        Map<String, dynamic> userData = {
                          'name': _nameController.text,
                          'email': _emailController.text,
                          'endereco': _enderecoController.text,
                        };

                        model.signUp(
                            userData: userData,
                            pass: _passwordController.text,
                            onSucess: _onSucess,
                            onFailure: _onFailure);
                      }

                      //limpar depois do cadastro
                      clearControllers();
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
          );
      }),
    );
  }

  void _onSucess() {}

  void _onFailure() {}
}