import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopApp/utils/size_config.dart';
import 'package:provider/provider.dart';

class DrawerView extends StatelessWidget {
  static const List<DrawerOption> drawerOptions = [
    DrawerOption(Icons.shopping_cart, 'Loja', '/'),
    DrawerOption(Icons.credit_card, 'Compras', 'orders'),
    DrawerOption(Icons.edit, 'Gerenciar produtos', 'products_list'),
  ];

  @override
  Widget build(BuildContext context) {
    User user = context.watch<User>();

    return Drawer(
      child: Column(
        children: [
          Container(
            height: SizeConfig.blockSizeVertical * 20,
            width: double.maxFinite,
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Seja bem-vindo(a) ${user?.email}'),
                IconButton(
                    icon: Icon(Icons.exit_to_app),
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                    })
              ],
            )),
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
