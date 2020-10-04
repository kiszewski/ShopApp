import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/models/cart_model.dart';
import 'package:shopApp/models/product_model.dart';
import 'package:shopApp/pages/home_page/components/product_card_view.dart';
import 'package:shopApp/size_config.dart';

class HomePage extends StatelessWidget {
  final String title;
  final List<ProductModel> products;

  static const Map<String, IconData> drawerOptions = {
    'Shop': Icons.shopping_cart,
    'Orders': Icons.credit_card,
    'Manage Products': Icons.edit
  };

  const HomePage(this.title, this.products);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
          Center(
            child: Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {},
                ),
                Positioned(
                  right: 10,
                  top: 5,
                  child: ClipRRect(
                    child: Container(
                      width: SizeConfig.blockSizeHorizontal * 3,
                      height: SizeConfig.blockSizeHorizontal * 3,
                      color: Colors.deepOrange,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Consumer<CartModel>(
                          builder: (context, cart, child) {
                            return Text(cart.qtdProducts.toString());
                          },
                        ),
                      ),
                    ),
                    borderRadius: BorderRadius.circular(90),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              height: SizeConfig.blockSizeVertical * 20,
              width: double.maxFinite,
              child: Center(child: Text('Hello Friend!')),
              color: Theme.of(context).primaryColor,
            ),
            Container(
              height: SizeConfig.blockSizeVertical * 80,
              width: double.maxFinite,
              child: ListView.builder(
                  itemCount: drawerOptions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(drawerOptions.values.toList()[index]),
                      title: Text(drawerOptions.keys.toList()[index]),
                    );
                  }),
            ),
          ],
        ),
      ),
      body: Center(
        child: GridView.count(
          childAspectRatio: 1.5,
          crossAxisCount: 2,
          padding: EdgeInsets.all(SizeConfig.blockSizeVertical * 1.5),
          crossAxisSpacing: SizeConfig.blockSizeVertical * 1.5,
          mainAxisSpacing: SizeConfig.blockSizeVertical * 1.5,
          children: products.map((e) => ProductCardView(e)).toList(),
        ),
      ),
    );
  }
}
