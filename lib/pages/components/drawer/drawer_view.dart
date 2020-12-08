import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopApp/pages/components/loading_dialog/loading_dialog_view.dart';
import 'package:shopApp/utils/size_config.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/viewmodels/login_viewmodel.dart';

class DrawerView extends StatelessWidget {
  static const List<DrawerOption> drawerOptions = [
    DrawerOption(Icons.shopping_cart, 'Loja', 'home'),
    DrawerOption(Icons.credit_card, 'Compras', 'orders'),
    DrawerOption(Icons.edit, 'Gerenciar produtos', 'products_list'),
  ];

  _logout(BuildContext context, LoginViewModel loginViewModel) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return LoadingDialogView('Saindo');
      },
    );
    await loginViewModel.logoutUser();
    Navigator.pushNamedAndRemoveUntil(
        context, '/', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final LoginViewModel loginViewModel = Provider.of<LoginViewModel>(context);

    return Drawer(
      child: Column(
        children: [
          Container(
            height: SizeConfig.blockSizeVertical * 20,
            width: double.maxFinite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamBuilder<User>(
                    stream: loginViewModel.userStream,
                    builder: (context, snapshot) {
                      return Text(
                        'Seja bem-vindo(a) ${snapshot.data?.displayName}',
                        style: TextStyle(color: Colors.white),
                      );
                    }),
                IconButton(
                    icon: Icon(Icons.exit_to_app),
                    color: Colors.white,
                    onPressed: () {
                      _logout(context, loginViewModel);
                    })
              ],
            ),
            color: Theme.of(context).primaryColor,
          ),
          Container(
            height: SizeConfig.blockSizeVertical * 80,
            width: double.maxFinite,
            child: ListView.builder(
                itemCount: drawerOptions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(drawerOptions[index]._icon),
                    title: Text(drawerOptions[index]._title),
                    onTap: () => Navigator.pushReplacementNamed(
                        context, drawerOptions[index]._route),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class DrawerOption {
  final IconData _icon;
  final String _title;
  final String _route;

  const DrawerOption(this._icon, this._title, this._route);
}
