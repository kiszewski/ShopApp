import 'package:flutter/material.dart';
import 'package:shopApp/models/product_model.dart';
import 'package:shopApp/utils/size_config.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductDetailsPage extends StatelessWidget {
  final ProductModel product;

  const ProductDetailsPage({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // final ProductModel product = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black87),
          title: Text(
            product.name,
            style: TextStyle(color: Colors.black87),
          ),
          backgroundColor: Colors.white12,
          elevation: 0,
        ),
        body: Column(
          children: [
            Container(
              width: SizeConfig.blockSizeHorizontal * 100,
              height: SizeConfig.blockSizeVertical * 40,
              child: Hero(
                tag: '${product.id}',
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              '\$ ${product.price}',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(height: 10),
            Text(
              product.description,
              style: TextStyle(fontSize: 15),
            )
          ],
        ));
  }
}
