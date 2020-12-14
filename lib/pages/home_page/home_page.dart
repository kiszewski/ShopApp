import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/models/product_model.dart';
import 'package:shopApp/pages/components/drawer/drawer_view.dart';
import 'package:shopApp/viewmodels/cart_viewmodel.dart';
import 'package:shopApp/viewmodels/favorite_viewmodel.dart';
import 'package:shopApp/services/products_service.dart';
import 'package:shopApp/pages/home_page/product_card_component.dart';
import 'package:shopApp/utils/size_config.dart';

class HomePage extends StatefulWidget {
  final String title;

  HomePage(this.title);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _onlyFavorites = false;

  final ProductsService _productsService =
      ProductsService(FirebaseFirestore.instance);

  Stream<List<ProductModel>> _productsStream;
  Future<List<ProductModel>> _favoritesFuture;

  FavoriteViewModel _favoriteModel;

  @override
  void initState() {
    super.initState();
    _favoriteModel = Provider.of<FavoriteViewModel>(context, listen: false);

    _productsStream = _productsService.getProducts();
    _favoritesFuture = _favoriteModel.favorites;
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
            ? FutureBuilder<List<ProductModel>>(
                key: Key('1'),
                future: _favoritesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return snapshot.data != null && snapshot.data.isNotEmpty
                        ? GridView.builder(
                            itemBuilder: (context, index) {
                              return ProductCardComponent(
                                  snapshot.data.toList()[index]);
                            },
                            physics: BouncingScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1.5,
                              crossAxisSpacing:
                                  SizeConfig.blockSizeVertical * 1.5,
                              mainAxisSpacing:
                                  SizeConfig.blockSizeVertical * 1.5,
                            ),
                            itemCount: snapshot.data.length,
                            padding: EdgeInsets.all(
                                SizeConfig.blockSizeVertical * 1.5),
                          )
                        : Container(
                            width: SizeConfig.blockSizeHorizontal * 100,
                            height: SizeConfig.blockSizeVertical * 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/shop.png'),
                                _onlyFavorites
                                    ? Text(
                                        'Lista de favoritos vazia',
                                        style: TextStyle(fontSize: 16),
                                      )
                                    : Text(
                                        'Lista de produtos vazia',
                                        style: TextStyle(fontSize: 16),
                                      ),
                              ],
                            ));
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )
            : StreamBuilder<List<ProductModel>>(
                key: Key('2'),
                stream: _productsStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error);
                  }

                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator());
                      break;
                    default:
                      return snapshot.data.isNotEmpty
                          ? GridView.builder(
                              itemBuilder: (context, index) {
                                return ProductCardComponent(
                                    snapshot.data[index]);
                              },
                              physics: BouncingScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1.5,
                                crossAxisSpacing:
                                    SizeConfig.blockSizeVertical * 1.5,
                                mainAxisSpacing:
                                    SizeConfig.blockSizeVertical * 1.5,
                              ),
                              itemCount: snapshot.data.length,
                              padding: EdgeInsets.all(
                                  SizeConfig.blockSizeVertical * 1.5),
                            )
                          : Container(
                              width: SizeConfig.blockSizeHorizontal * 100,
                              height: SizeConfig.blockSizeVertical * 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/shop.png'),
                                  _onlyFavorites
                                      ? Text(
                                          'Lista de favoritos vazia',
                                          style: TextStyle(fontSize: 16),
                                        )
                                      : Text(
                                          'Lista de produtos vazia',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                ],
                              ));
                  }
                },
              ));
  }
}
