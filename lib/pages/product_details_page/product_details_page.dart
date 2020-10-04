import 'package:flutter/material.dart';
import 'package:shopApp/models/product_model.dart';
import 'package:shopApp/size_config.dart';

class ProductDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProductModel product = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(
          title: Text(product.name),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              width: SizeConfig.blockSizeHorizontal * 100,
              height: SizeConfig.blockSizeVertical * 40,
              child: FittedBox(
                  fit: BoxFit.cover, child: Image.network(product.imageUrl)),
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
