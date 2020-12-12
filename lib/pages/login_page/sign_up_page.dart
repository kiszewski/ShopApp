import 'package:flutter/material.dart';
import 'package:shopApp/pages/components/loading_dialog/loading_dialog_view.dart';
import 'package:shopApp/utils/general_form_field_validator.dart';
import 'package:shopApp/utils/size_config.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/viewmodels/login_viewmodel.dart';

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

  // _signUp(BuildContext ctx, LoginViewModel loginViewModel) async {
  //   if (_formKey.currentState.validate()) {
  //     showDialog(
  //         context: ctx,
  //         barrierDismissible: false,
  //         child: LoadingDialogView('Cadastrando...'));

  //     String resp = await loginViewModel.createUser(
  //       _email.text,
  //       _password.text,
  //     );

  //     Navigator.of(context).pop();

  //     if (await loginViewModel.loggedUser) {
  //       Navigator.of(context).pushReplacementNamed('home');
  //     } else {
  //       _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(resp)));
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final LoginViewModel loginViewModel = Provider.of<LoginViewModel>(context);

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
                          fontSize: 24,
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.bold))
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
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      onPressed: () {
                        // _signUp(context, loginViewModel);
                      },
                      child: Text(
                        'Criar conta',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
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
