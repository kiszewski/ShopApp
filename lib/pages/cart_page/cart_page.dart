import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/models/cart_model.dart';
import 'package:shopApp/models/product_model.dart';
import 'package:shopApp/utils/size_config.dart';

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
            height: SizeConfig.blockSizeVertical * 75,
            child: ListView.builder(
              itemCount: cartModel.qtdProducts,
              padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2.5),
              itemBuilder: (context, index) {
                final ProductModel product =
                    cartModel.productsInCart.toList()[index];
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
                                cartModel.increaseQtd(product);
                              },
                            ),
                            Text('${product.qtd}'),
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                              icon: Icon(Icons.keyboard_arrow_down),
                              onPressed: () {
                                cartModel.decreaseQtd(product);
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                cartModel.removeProduct(product);
                              },
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
                        //TO DO: A Image Class to show both network or file
                        child: Image.network(product.imageUrl),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            width: SizeConfig.blockSizeHorizontal * 100,
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal * 5,
              vertical: SizeConfig.blockSizeVertical * 2,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Total: R\$ ${cartModel.totalInCart.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          FlatButton(
            onPressed: () => cartModel.order(context),
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal * 25),
            textColor: Colors.white,
            child: Text('Finalizar Compra'),
          )
        ],
      ),
    );
  }
}
