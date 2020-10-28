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

  bool _showPassword = false;

  _toggleShowPassword() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  _signIn() async {
    if (_formKey.currentState.validate()) {
      SnackBar(
        duration: Duration(seconds: 4),
        content: Row(
          children: <Widget>[
            CircularProgressIndicator(),
            Text("  Signing-In...")
          ],
        ),
      );
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
        title: Text('Login'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    'Seja bem-vindo',
                    style: TextStyle(
                        fontSize: 24,
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 4),
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
                    suffixIcon: IconButton(
                      icon: Icon(_showPassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: _toggleShowPassword,
                    )),
                obscureText: _showPassword ? false : true,
                keyboardType: TextInputType.visiblePassword,
                validator: GeneralFormFieldValidator.passwordValidator,
                enableSuggestions: false,
                autocorrect: false,
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              Row(
                children: [
                  Expanded(
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      onPressed: _signIn,
                      child: Text(
                        'Entrar',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              OutlineButton(
                child: Text(
                  'Criar conta',
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('sign_up');
                },
                borderSide: BorderSide(width: 0, color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
