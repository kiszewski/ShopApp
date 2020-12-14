import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/pages/product_details_page/product_details_page.dart';
import 'package:shopApp/viewmodels/cart_viewmodel.dart';
import 'package:shopApp/viewmodels/favorite_viewmodel.dart';
import 'package:shopApp/models/product_model.dart';
import 'package:shopApp/utils/size_config.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductCardComponent extends StatefulWidget {
  final ProductModel product;

  const ProductCardComponent(this.product);

  @override
  _ProductCardComponentState createState() => _ProductCardComponentState();
}

class _ProductCardComponentState extends State<ProductCardComponent> {
  FavoriteViewModel favoriteModel;
  // Future<bool> isFavoriteFuture;
  @override
  void initState() {
    super.initState();
    favoriteModel = Provider.of<FavoriteViewModel>(context, listen: false);
    // isFavoriteFuture = favoriteModel.isFavorite(widget.product);
  }

  @override
  Widget build(BuildContext context) {
    FavoriteViewModel favoriteModel2 = Provider.of<FavoriteViewModel>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: GestureDetector(
        onTap: () => Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 250),
                pageBuilder: (_, __, ___) =>
                    ProductDetailsPage(product: widget.product))),
        child: Stack(
          children: [
            Container(
              height: SizeConfig.blockSizeVertical * 25,
              width: SizeConfig.blockSizeVertical * 25,
              child: Hero(
                tag: '${widget.product.id}',
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: widget.product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                color: Color.fromRGBO(0, 0, 0, 0.75),
                width: SizeConfig.blockSizeVertical * 24,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        icon: FutureBuilder<bool>(
                          future: favoriteModel2.isFavorite(widget.product),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return Icon(
                                snapshot.data
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Theme.of(context).primaryColor,
                              );
                            } else {
                              return Icon(
                                snapshot.data != null && snapshot.data
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Theme.of(context).primaryColor,
                              );
                            }
                          },
                        ),
                        onPressed: () =>
                            favoriteModel.toggleFavorite(widget.product)),

                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          widget.product.name,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.shopping_cart,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () => print('')),
                    // onPressed: () => _addInCart(context)),
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
