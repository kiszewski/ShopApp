import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/models/product_model.dart';
import 'package:shopApp/pages/components/drawer/drawer_view.dart';
import 'package:shopApp/viewmodels/favorite_viewmodel.dart';
import 'package:shopApp/viewmodels/products_viewmodel.dart';
import 'package:shopApp/utils/size_config.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductsListPage extends StatefulWidget {
  @override
  _ProductsListPageState createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  @override
  Widget build(BuildContext context) {
    final ProductsViewModel productsViewModel =
        Provider.of<ProductsViewModel>(context);
    final FavoriteViewModel favoriteViewModel =
        Provider.of<FavoriteViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Produtos',
          style: TextStyle(color: Colors.black54),
        ),
        elevation: 0,
        backgroundColor: Colors.white12,
        iconTheme: IconThemeData(color: Colors.black54),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              color: Theme.of(context).primaryColor,
              onPressed: () => Navigator.pushNamed(context, 'product_form'))
        ],
      ),
      drawer: DrawerView(),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: productsViewModel.qtdProducts,
        itemBuilder: (context, index) {
          final ProductModel product = productsViewModel.products[index];

          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(24))),
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
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed('product_form', arguments: product);
                      }),
                  IconButton(
                      icon: Icon(Icons.delete),
                      color: Colors.redAccent,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Excluir produto'),
                              content: Text(
                                  'Você deseja excluir o produto ${product.name}?'),
                              actions: [
                                FlatButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text('Cancelar'),
                                  textColor: Colors.grey,
                                ),
                                FlatButton(
                                  onPressed: () {
                                    if (favoriteViewModel.favorites
                                        .contains(product)) {
                                      favoriteViewModel.toggleFavorite(product);
                                    }

                                    productsViewModel.removeProduct(product);
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Excluir'),
                                )
                              ],
                            );
                          },
                        );
                      })
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
