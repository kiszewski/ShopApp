import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/models/item_cart_model.dart';
import 'package:shopApp/repository/user_repository.dart';
import 'package:shopApp/utils/size_config.dart';
import 'package:transparent_image/transparent_image.dart';

class ItemCartComponent extends StatelessWidget {
  final ItemCartModel product;

  const ItemCartComponent(this.product);

  @override
  Widget build(BuildContext context) {
    final UserRepository _userRepository = Provider.of<UserRepository>(context);

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
                      onPressed: () {
                        product.qtd++;
                        _userRepository.updateQtdItemCart(product);
                      },
                    ),
                    Text(product.qtd.toString()),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        if (product.qtd > 1) {
                          product.qtd--;
                          _userRepository.updateQtdItemCart(product);
                        }
                      },
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.red,
                ),
                onPressed: () => _userRepository.removeFromCart(product),
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
