import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/models/product_model.dart';
import 'package:shopApp/pages/home_page/product_card_component.dart';
import 'package:shopApp/utils/size_config.dart';
import 'package:shopApp/viewmodels/favorites_viewmodel.dart';

class FavoritesListComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FavoritesViewModel _favoritesViewModel =
        Provider.of<FavoritesViewModel>(context, listen: false);

    return StreamBuilder<List<ProductModel>>(
      key: Key('1'),
      initialData: [],
      stream: _favoritesViewModel.favorites,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          return snapshot.data != null && snapshot.data.isNotEmpty
              ? GridView.builder(
                  itemBuilder: (context, index) {
                    return ProductCardComponent(
                        snapshot.data.toList()[index], true);
                  },
                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.5,
                    crossAxisSpacing: SizeConfig.blockSizeVertical * 1.5,
                    mainAxisSpacing: SizeConfig.blockSizeVertical * 1.5,
                  ),
                  itemCount: snapshot.data.length,
                  padding: EdgeInsets.all(SizeConfig.blockSizeVertical * 1.5),
                )
              : Container(
                  width: SizeConfig.blockSizeHorizontal * 100,
                  height: SizeConfig.blockSizeVertical * 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/shop.png'),
                      Text(
                        'Lista de favoritos vazia',
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ));
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
