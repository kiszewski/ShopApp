import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/models/product_model.dart';
import 'package:shopApp/models/products_model.dart';
import 'package:shopApp/pages/home_page/components/drawer_view.dart';
import 'package:shopApp/utils/size_config.dart';

class ProductsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProductsModel productsModel = Provider.of<ProductsModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: [IconButton(icon: Icon(Icons.add), onPressed: () {})],
      ),
      drawer: DrawerView(),
      body: ListView.builder(
        itemCount: productsModel.qtdProducts,
        itemBuilder: (context, index) {
          final ProductModel product = productsModel.products[index];

          return Card(
            elevation: 5,
            child: ListTile(
              title: Text(product.name),
              leading: ClipOval(
                child: Container(
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    height: SizeConfig.blockSizeHorizontal * 12,
                    width: SizeConfig.blockSizeHorizontal * 12,
                  ),
                ),
              ),
              trailing: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(icon: Icon(Icons.edit), onPressed: () {}),
                  IconButton(icon: Icon(Icons.delete), onPressed: () {})
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
