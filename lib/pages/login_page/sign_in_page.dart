import 'package:flutter/material.dart';
import 'package:shopApp/services/authentication_service.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/utils/general_form_field_validator.dart';
import 'package:shopApp/utils/size_config.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  _signIn() async {
    if (_formKey.currentState.validate()) {
      String resp = await context.read<AuthenticationService>().signIn(
            email: _email.text,
            password: _password.text,
          );
      if (resp == 'User criado') {
        Navigator.of(context).pushReplacementNamed('home');
      } else {
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(resp)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Sign In'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: _email,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: GeneralFormFieldValidator.emailValidator,
              ),
              TextFormField(
                controller: _password,
                decoration: InputDecoration(
                  labelText: 'Senha',
                ),
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                validator: GeneralFormFieldValidator.passwordValidator,
                enableSuggestions: false,
                autocorrect: false,
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: FlatButton(
                      color: Theme.of(context).accentColor,
                      textColor: Colors.white,
                      child: Text('Cadastrar'),
                      onPressed: () {
                        Navigator.of(context).pushNamed('sign_up');
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: FlatButton(
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      child: Text('Entrar'),
                      onPressed: _signIn,
                    ),
                  ),
                ],
              )
            ],
          ),
          key: _formKey,
        ),
      ),
    );
  }
}
