import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopApp/models/product_model.dart';
import 'package:shopApp/pages/home_page/product_card_component.dart';
import 'package:shopApp/repository/product_repository.dart';
import 'package:shopApp/repository/user_repository.dart';
import 'package:shopApp/utils/size_config.dart';

class ProductsListComponent extends StatelessWidget {
  final ProductRepository _productRepository =
      ProductRepository(FirebaseFirestore.instance);
  final UserRepository _userRepository =
      UserRepository(FirebaseFirestore.instance);

  @override
  Widget build(BuildContext context) {
    final Stream<List<ProductModel>> _productsStream =
        _productRepository.getProducts();
    final Stream<List<ProductModel>> _favoritesStream =
        _userRepository.getFavorites();

    return StreamBuilder<List<ProductModel>>(
      key: Key('2'),
      stream: _productsStream,
      builder: (context, productsSnapshot) {
        return StreamBuilder<List<ProductModel>>(
          stream: _favoritesStream,
          builder: (context, favoritesSnapshot) {
            if (productsSnapshot.hasError) {
              return Text(productsSnapshot.error);
            }

            switch (productsSnapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
                break;
              default:
                return productsSnapshot.data.isNotEmpty
                    ? GridView.builder(
                        itemBuilder: (context, index) {
                          bool isFavorite = favoritesSnapshot.data.any(
                              (favorite) =>
                                  favorite.id ==
                                  productsSnapshot.data[index].id);
                          return ProductCardComponent(
                              productsSnapshot.data[index], isFavorite);
                        },
                        physics: BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.5,
                          crossAxisSpacing: SizeConfig.blockSizeVertical * 1.5,
                          mainAxisSpacing: SizeConfig.blockSizeVertical * 1.5,
                        ),
                        itemCount: productsSnapshot.data.length,
                        padding:
                            EdgeInsets.all(SizeConfig.blockSizeVertical * 1.5),
                      )
                    : Container(
                        width: SizeConfig.blockSizeHorizontal * 100,
                        height: SizeConfig.blockSizeVertical * 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/shop.png'),
                            Text(
                              'Lista de produtos vazia',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ));
            }
          },
        );
      },
    );
  }
}
