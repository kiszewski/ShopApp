import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/models/cart_model.dart';
import 'package:shopApp/models/favorite_model.dart';
import 'package:shopApp/models/products_model.dart';
import 'package:shopApp/pages/home_page/components/drawer_view.dart';
import 'package:shopApp/pages/home_page/components/product_card_view.dart';
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
    final ProductsModel productsModel = Provider.of<ProductsModel>(context);
    final FavoriteModel favoriteModel = Provider.of<FavoriteModel>(context);
    SizeConfig().init(context);

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
                        child: Consumer<CartModel>(
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
      body: Center(
        child: GridView.count(
          childAspectRatio: 1.5,
          crossAxisCount: 2,
          padding: EdgeInsets.all(SizeConfig.blockSizeVertical * 1.5),
          crossAxisSpacing: SizeConfig.blockSizeVertical * 1.5,
          mainAxisSpacing: SizeConfig.blockSizeVertical * 1.5,
          children: onlyFavorites
              ? favoriteModel.favorites.map((e) => ProductCardView(e)).toList()
              : productsModel.products.map((e) => ProductCardView(e)).toList(),
        ),
      ),
    );
  }
}
