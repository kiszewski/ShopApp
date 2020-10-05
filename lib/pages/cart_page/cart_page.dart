import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/models/cart_model.dart';
import 'package:shopApp/size_config.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CartModel cartModel = Provider.of<CartModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho de compras'),
      ),
      body: ListView.builder(
        itemCount: cartModel.qtdProducts,
        padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2.5),
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
            trailing: Text('x1'),
            title: Text(cartModel.productsInCart.toList()[index].name),
            leading: Container(
              width: SizeConfig.blockSizeHorizontal * 15,
              height: SizeConfig.blockSizeHorizontal * 15,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Image.network(
                      cartModel.productsInCart.toList()[index].imageUrl),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
