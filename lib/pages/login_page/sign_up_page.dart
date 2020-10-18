import 'package:flutter/material.dart';
import 'package:shopApp/services/authentication_service.dart';
import 'package:shopApp/utils/size_config.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
              ),
              TextFormField(
                controller: _password,
                decoration: InputDecoration(
                  labelText: 'Senha',
                ),
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                enableSuggestions: false,
                autocorrect: false,
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 4,
              ),
              FlatButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockSizeHorizontal * 25,
                ),
                child: Text('Criar conta'),
                onPressed: () async {
                  String resp =
                      await context.read<AuthenticationService>().signUp(
                            email: _email.text,
                            password: _password.text,
                          );
                  if (resp == 'User criado') {
                    Navigator.of(context).pushReplacementNamed('home');
                  } else {
                    _scaffoldKey.currentState
                        .showSnackBar(SnackBar(content: Text(resp)));
                  }
                },
              )
            ],
          ),
          key: _formKey,
        ),
      ),
    );
  }
}
