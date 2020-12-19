import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/models/product_model.dart';
import 'package:shopApp/pages/components/drawer/drawer_view.dart';
import 'package:shopApp/repository/product_repository.dart';
import 'package:shopApp/utils/size_config.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductsListPage extends StatefulWidget {
  @override
  _ProductsListPageState createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  @override
  Widget build(BuildContext context) {
    ProductRepository _productRepository =
        Provider.of<ProductRepository>(context);
    Stream<List<ProductModel>> _productsStream =
        _productRepository.getProducts();

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
        body: StreamBuilder<List<ProductModel>>(
            stream: _productsStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print(snapshot.data);
                return Text('Error: ${snapshot.error}');
              }
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                default:
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      final ProductModel product = snapshot?.data[index];
                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(24))),
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
                                    Navigator.of(context).pushNamed(
                                        'product_form',
                                        arguments: product);
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
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                              child: Text('Cancelar'),
                                              textColor: Colors.grey,
                                            ),
                                            FlatButton(
                                              onPressed: () async {
                                                // if (await favoriteViewModel
                                                //     .isFavorite(product)) {
                                                //   favoriteViewModel
                                                //       .toggleFavorite(product);
                                                // }

                                                _productRepository
                                                    .removeProduct(product);
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
                  );
              }
            }));
    ;
  }
}
