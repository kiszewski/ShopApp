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
        title: Text('Sign Up'),
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
              TextFormField(
                controller: _confirmPassword,
                decoration: InputDecoration(
                  labelText: 'Confirme a senha',
                ),
                obscureText: true,
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
              FlatButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockSizeHorizontal * 40,
                ),
                child: FittedBox(child: Text('Criar conta')),
                onPressed: _signUp,
              )
            ],
          ),
          key: _formKey,
        ),
      ),
    );
  }
}
