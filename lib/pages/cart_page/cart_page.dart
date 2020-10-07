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
      body: Column(
        children: [
          Container(
            width: SizeConfig.blockSizeHorizontal * 100,
            height: SizeConfig.blockSizeVertical * 80,
            child: ListView.builder(
              itemCount: cartModel.qtdProducts,
              padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2.5),
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding:
                      EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
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
                              onPressed: () {
                                cartModel.increaseQtd(
                                    cartModel.productsInCart.toList()[index]);
                              },
                            ),
                            Text(
                                '${cartModel.productsInCart.toList()[index].qtd}'),
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                              icon: Icon(Icons.keyboard_arrow_down),
                              onPressed: () {
                                cartModel.decreaseQtd(
                                    cartModel.productsInCart.toList()[index]);
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                cartModel.removeProduct(
                                    cartModel.productsInCart.toList()[index]);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
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
          ),
          Text('${cartModel.totalInCart().toString()}'),
          FlatButton(onPressed: () {}, child: Text('Finalizar Compras'))
        ],
      ),
    );
  }
}
