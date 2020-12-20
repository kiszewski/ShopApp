import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/pages/components/drawer/drawer_view.dart';
import 'package:shopApp/pages/home_page/favorites_list_component.dart';
import 'package:shopApp/pages/home_page/products_list_component.dart';
import 'package:shopApp/viewmodels/cart_viewmodel.dart';
import 'package:shopApp/utils/size_config.dart';

class HomePage extends StatefulWidget {
  final String title;

  HomePage(this.title);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _onlyFavorites = false;

  @override
  void initState() {
    super.initState();
  }

  _changeProductsList(bool value) {
    setState(() {
      _onlyFavorites = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black87),
          title: Text(
            widget.title,
            style: TextStyle(color: Colors.black87),
          ),
          backgroundColor: Colors.white12,
          elevation: 0,
          actions: [
            Center(
              child: DropdownButton(
                dropdownColor: Colors.white,
                iconEnabledColor: Colors.black87,
                underline: SizedBox(),
                icon: Icon(Icons.more_vert),
                onChanged: _changeProductsList,
                items: [
                  DropdownMenuItem(
                      child: Text('Somente favoritos'), value: true),
                  DropdownMenuItem(child: Text('Mostrar todos'), value: false)
                ],
              ),
            ),
            Center(
              child: Stack(
                children: [
                  IconButton(
                    icon: Icon(Icons.shopping_cart),
                    color: Colors.black87,
                    onPressed: () => Navigator.pushNamed(context, 'cart'),
                  ),
                  Positioned(
                    right: 10,
                    top: 5,
                    child: ClipRRect(
                      child: Container(
                        width: SizeConfig.blockSizeHorizontal * 3,
                        height: SizeConfig.blockSizeHorizontal * 3,
                        color: Theme.of(context).primaryColor,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Consumer<CartViewModel>(
                            builder: (context, cart, child) {
                              return Text(cart.qtdProducts.toString());
                            },
                          ),
                        ),
                      ),
                      borderRadius: BorderRadius.circular(90),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        drawer: DrawerView(),
        body: _onlyFavorites
            ? FavoritesListComponent()
            : ProductsListComponent());
  }
}
