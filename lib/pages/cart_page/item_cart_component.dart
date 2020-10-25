import 'package:flutter/material.dart';
import 'package:shopApp/models/product_model.dart';
import 'package:shopApp/utils/size_config.dart';
import 'package:shopApp/viewmodels/cart_viewmodel.dart';
import 'package:transparent_image/transparent_image.dart';

class ItemCartComponent extends StatelessWidget {
  final ProductModel product;
  final CartViewModel cartModel;

  const ItemCartComponent(this.product, this.cartModel);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
      trailing: Container(
        width: 140,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  icon: Icon(
                    Icons.keyboard_arrow_up,
                  ),
                  onPressed: () => cartModel.increaseQtd(product),
                ),
                Text('${product.qtd}'),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  icon: Icon(Icons.keyboard_arrow_down),
                  onPressed: () => cartModel.decreaseQtd(product),
                ),
                IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.red,
                  ),
                  onPressed: () => cartModel.removeProduct(product),
                ),
              ],
            ),
          ],
        ),
      ),
      title: Text(product.name),
      leading: Container(
        width: SizeConfig.blockSizeHorizontal * 15,
        height: SizeConfig.blockSizeHorizontal * 15,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: FittedBox(
            fit: BoxFit.cover,
            child: FadeInImage.memoryNetwork(
              fadeInDuration: Duration(seconds: 2),
              placeholder: kTransparentImage,
              image: product.imageUrl,
            ),
          ),
        ),
      ),
    );
  }
}
