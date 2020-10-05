import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/models/cart_model.dart';
import 'package:shopApp/models/favorite_model.dart';
import 'package:shopApp/models/product_model.dart';
import 'package:shopApp/size_config.dart';

class ProductCardView extends StatelessWidget {
  final ProductModel product;

  const ProductCardView(this.product);

  @override
  Widget build(BuildContext context) {
    final FavoriteModel favoriteModel = Provider.of<FavoriteModel>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () => Navigator.of(context)
            .pushNamed('product_details', arguments: product),
        child: Stack(
          children: [
            Container(
              height: SizeConfig.blockSizeVertical * 25,
              width: SizeConfig.blockSizeVertical * 25,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                color: Colors.black54,
                width: SizeConfig.blockSizeVertical * 24,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        icon: Icon(
                          favoriteModel.isFavorite(product)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.deepOrange,
                        ),
                        onPressed: () => favoriteModel.toggleFavorite(product)),
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          product.name,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.shopping_cart,
                          color: Colors.deepOrange,
                        ),
                        onPressed: () {
                          Provider.of<CartModel>(context, listen: false)
                              .addProduct(product);
                        }),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
