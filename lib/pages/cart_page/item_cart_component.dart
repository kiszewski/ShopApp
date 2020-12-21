import 'package:flutter/material.dart';
import 'package:shopApp/models/item_cart_model.dart';
import 'package:shopApp/utils/size_config.dart';
import 'package:shopApp/viewmodels/cart_viewmodel.dart';
import 'package:transparent_image/transparent_image.dart';

class ItemCartComponent extends StatelessWidget {
  final ItemCartModel product;
  final CartViewModel cartViewModel;

  const ItemCartComponent(this.product, this.cartViewModel);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shadowColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
        trailing: Container(
          width: 140,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FittedBox(
                child: Column(
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      icon: Icon(
                        Icons.keyboard_arrow_up,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () => print(''),
                    ),
                    Text('qtd X'),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () => print(''),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.red,
                ),
                onPressed: () => print('remove'),
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
      ),
    );
  }
}
