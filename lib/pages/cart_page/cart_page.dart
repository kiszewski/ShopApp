import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/pages/cart_page/item_cart_component.dart';
import 'package:shopApp/viewmodels/cart_viewmodel.dart';
import 'package:shopApp/models/product_model.dart';
import 'package:shopApp/utils/size_config.dart';
import 'package:transparent_image/transparent_image.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final CartViewModel cartModel = Provider.of<CartViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho de compras'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Container(
              width: SizeConfig.blockSizeHorizontal * 100,
              height: SizeConfig.blockSizeVertical * 70,
              child: ListView.builder(
                itemCount: cartModel.qtdProducts,
                itemBuilder: (context, index) {
                  final ProductModel product =
                      cartModel.productsInCart.toList()[index];
                  return ItemCartComponent(product, cartModel);
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
            Row(
              children: [
                Expanded(
                  child: FlatButton(
                    onPressed: () => cartModel.order(context),
                    color: Theme.of(context).primaryColor,
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.blockSizeHorizontal * 25),
                    textColor: Colors.white,
                    child: Text('Finalizar Compra'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
