import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopApp/models/product_model.dart';
import 'package:shopApp/pages/home_page/product_card_component.dart';
import 'package:shopApp/repository/product_repository.dart';
import 'package:shopApp/utils/size_config.dart';

class ProductsListComponent extends StatelessWidget {
  final ProductRepository _productRepository =
      ProductRepository(FirebaseFirestore.instance);

  @override
  Widget build(BuildContext context) {
    final Stream<List<ProductModel>> _productsStream =
        _productRepository.getProducts();

    return StreamBuilder<List<ProductModel>>(
      key: Key('2'),
      stream: _productsStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error);
        }

        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
            break;
          default:
            return snapshot.data.isNotEmpty
                ? GridView.builder(
                    itemBuilder: (context, index) {
                      return ProductCardComponent(snapshot.data[index]);
                    },
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.5,
                      crossAxisSpacing: SizeConfig.blockSizeVertical * 1.5,
                      mainAxisSpacing: SizeConfig.blockSizeVertical * 1.5,
                    ),
                    itemCount: snapshot.data.length,
                    padding: EdgeInsets.all(SizeConfig.blockSizeVertical * 1.5),
                  )
                : Container(
                    width: SizeConfig.blockSizeHorizontal * 100,
                    height: SizeConfig.blockSizeVertical * 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/shop.png'),
                        Text(
                          'Lista de produtos vazia',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ));
        }
      },
    );
  }
}
