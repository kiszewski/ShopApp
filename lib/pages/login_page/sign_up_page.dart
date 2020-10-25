import 'package:flutter/material.dart';
import 'package:shopApp/services/authentication_service.dart';
import 'package:shopApp/utils/general_form_field_validator.dart';
import 'package:shopApp/utils/size_config.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();

  bool _showPassword = false;

  _toggleShowPassword() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  bool _showConfirmPassword = false;

  _toggleConfirmPassword() {
    setState(() {
      _showConfirmPassword = !_showConfirmPassword;
    });
  }

  _signUp() async {
    if (_formKey.currentState.validate()) {
      String resp = await context.read<AuthenticationService>().signUp(
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
        title: Text('Criar conta'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text('Crie a sua conta',
                      style: TextStyle(
                          fontSize: 24, color: Theme.of(context).accentColor))
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
              TextFormField(
                controller: _confirmPassword,
                decoration: InputDecoration(
                    labelText: 'Confirme a senha',
                    suffixIcon: IconButton(
                      icon: Icon(_showConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: _toggleConfirmPassword,
                    )),
                obscureText: _showConfirmPassword ? false : true,
                keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  if (value != _password.text) {
                    return 'As senhas devem ser iguais!';
                  } else
                    return null;
                },
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
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      child: Text('Criar conta'),
                      onPressed: _signUp,
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
