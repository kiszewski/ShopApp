import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/pages/cart_page/item_cart_component.dart';
import 'package:shopApp/viewmodels/cart_viewmodel.dart';
import 'package:shopApp/models/product_model.dart';
import 'package:shopApp/utils/size_config.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final CartViewModel cartViewModel = Provider.of<CartViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho de compras'),
      ),
      body: Container(
        color: Colors.white70,
        height: SizeConfig.blockSizeVertical * 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(left: 16, right: 16, top: 8),
              width: SizeConfig.blockSizeHorizontal * 100,
              height: SizeConfig.blockSizeVertical * 75,
              child: ListView.builder(
                primary: false,
                itemCount: cartViewModel.qtdProducts,
                itemBuilder: (context, index) {
                  final ProductModel product =
                      cartViewModel.productsInCart.toList()[index];
                  return ItemCartComponent(product, cartViewModel);
                },
              ),
            ),
            Container(
              height: SizeConfig.blockSizeVertical * 14,
              child: Card(
                elevation: 16,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                )),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: SizeConfig.blockSizeHorizontal * 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'R\$ ${cartViewModel.totalInCart.toStringAsFixed(2)}',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      SizeConfig.blockSizeHorizontal * 25),
                              color: Theme.of(context).primaryColor,
                              textColor: Colors.white,
                              onPressed: () => cartViewModel.order(context),
                              child: Text(
                                'Finalizar Compra',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
