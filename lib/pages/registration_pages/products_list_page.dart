import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/models/product_model.dart';
import 'package:shopApp/pages/components/drawer/drawer_view.dart';
import 'package:shopApp/viewmodels/products_viewmodel.dart';
import 'package:shopApp/utils/size_config.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProductsViewModel productsModel =
        Provider.of<ProductsViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Produtos'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () => Navigator.pushNamed(context, 'product_form'))
        ],
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
                    child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: product.imageUrl,
                  fit: BoxFit.cover,
                  height: SizeConfig.blockSizeHorizontal * 12,
                  width: SizeConfig.blockSizeHorizontal * 12,
                )),
              ),
              trailing: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed('product_form', arguments: product);
                      }),
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
