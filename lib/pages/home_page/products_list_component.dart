import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/models/product_model.dart';
import 'package:shopApp/pages/home_page/product_card_component.dart';
import 'package:shopApp/repository/user_repository.dart';
import 'package:shopApp/utils/size_config.dart';
import 'package:shopApp/viewmodels/products_viewmodel.dart';

class ProductsListComponent extends StatelessWidget {
  final UserRepository _userRepository =
      UserRepository(FirebaseFirestore.instance);

  @override
  Widget build(BuildContext context) {
    final _productsViewModel =
        Provider.of<ProductsViewModel>(context, listen: false);

    final Stream<List<ProductModel>> _favoritesStream =
        _userRepository.getFavorites();

    return StreamBuilder<List<ProductModel>>(
      key: Key('2'),
      initialData: [],
      stream: _productsViewModel.getProducts,
      builder: (context, productsSnapshot) {
        return StreamBuilder<List<ProductModel>>(
          initialData: [],
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
                          bool isFavorite = false;

                          if (favoritesSnapshot.data.isNotEmpty) {
                            isFavorite = favoritesSnapshot.data.any(
                                (favorite) =>
                                    favorite.id ==
                                    productsSnapshot.data[index].id);
                          }
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
