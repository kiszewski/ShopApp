import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/models/product_model.dart';
import 'package:shopApp/pages/components/drawer/drawer_view.dart';
import 'package:shopApp/pages/registration_pages/products_list_page.dart';
import 'package:shopApp/viewmodels/cart_viewmodel.dart';
import 'package:shopApp/viewmodels/favorite_viewmodel.dart';
import 'package:shopApp/viewmodels/products_viewmodel.dart';
import 'package:shopApp/pages/home_page/product_card_component.dart';
import 'package:shopApp/utils/size_config.dart';

class HomePage extends StatefulWidget {
  final String title;

  HomePage(this.title);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool onlyFavorites = false;

  _changeProductsList(bool value) {
    setState(() {
      onlyFavorites = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ProductsViewModel productsModel =
        Provider.of<ProductsViewModel>(context);
    final FavoriteViewModel favoriteModel =
        Provider.of<FavoriteViewModel>(context);

    final List<ProductModel> productsToShow = onlyFavorites
        ? favoriteModel.favorites.toList()
        : productsModel.products.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Center(
            child: DropdownButton(
              dropdownColor: Colors.white,
              iconEnabledColor: Colors.white,
              underline: SizedBox(),
              icon: Icon(Icons.more_vert),
              onChanged: _changeProductsList,
              items: [
                DropdownMenuItem(child: Text('Somente favoritos'), value: true),
                DropdownMenuItem(child: Text('Mostrar todos'), value: false)
              ],
            ),
          ),
          Center(
            child: Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () => Navigator.pushNamed(context, 'cart'),
                ),
                Positioned(
                  right: 10,
                  top: 5,
                  child: ClipRRect(
                    child: Container(
                      width: SizeConfig.blockSizeHorizontal * 3,
                      height: SizeConfig.blockSizeHorizontal * 3,
                      color: Colors.deepOrange,
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
      body: productsToShow.isNotEmpty
          ? GridView.builder(
              itemBuilder: (context, index) {
                return ProductCardComponent(productsToShow[index]);
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                crossAxisSpacing: SizeConfig.blockSizeVertical * 1.5,
                mainAxisSpacing: SizeConfig.blockSizeVertical * 1.5,
              ),
              itemCount: productsToShow.length,
              padding: EdgeInsets.all(SizeConfig.blockSizeVertical * 1.5),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: SizeConfig.blockSizeVertical * 5),
                Text('Lista de produtos vazia'),
              ],
            ),
    );
  }
}
