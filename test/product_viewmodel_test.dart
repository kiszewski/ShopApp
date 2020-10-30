import 'package:flutter_test/flutter_test.dart';
import 'package:shopApp/models/product_model.dart';
import 'package:shopApp/viewmodels/products_viewmodel.dart';

void main() {
  final ProductsViewModel productViewModel = ProductsViewModel([]);

  final ProductModel prod1 = ProductModel(
      'Camiseta',
      'https://lp2.hm.com/hmgoepprod?set=quality[79],source[/f5/c4/f5c4939114fcc731acfada4ebb68f1da42cad909.jpg],origin[dam],category[men_tshirtstanks_shortsleeve],type[DESCRIPTIVESTILLLIFE],res[m],hmver[1]&call=url[file:/product/main]',
      99.9,
      'Camiseta preta');

  group('Products ViewModel tests', () {
    test('Adding product in the list', () {
      expect(productViewModel.qtdProducts, 0);
      productViewModel.addProduct(prod1);
      expect(productViewModel.qtdProducts, 1);
      expect(productViewModel.products.contains(prod1), true);
    });
    test('Removing product in the list', () {
      expect(productViewModel.qtdProducts, 1);
      productViewModel.removeProduct(prod1);
      expect(productViewModel.qtdProducts, 0);
      expect(productViewModel.products.contains(prod1), false);
    });

    test('Updating product', () {
      productViewModel.addProduct(prod1);
      productViewModel.updateProduct(
        prod1,
        'Camiseta branca',
        'https://lp2.hm.com/hmgoepprod?set=quality[79],source[/f5/c4/f5c4939114fcc731acfada4ebb68f1da42cad909.jpg],origin[dam],category[men_tshirtstanks_shortsleeve],type[DESCRIPTIVESTILLLIFE],res[m],hmver[1]&call=url[file:/product/main]',
        99.9,
        'Camiseta branca GG',
      );

      expect(prod1.name, 'Camiseta branca');
      expect(prod1.imageUrl,
          'https://lp2.hm.com/hmgoepprod?set=quality[79],source[/f5/c4/f5c4939114fcc731acfada4ebb68f1da42cad909.jpg],origin[dam],category[men_tshirtstanks_shortsleeve],type[DESCRIPTIVESTILLLIFE],res[m],hmver[1]&call=url[file:/product/main]');
      expect(prod1.price, 99.9);
      expect(prod1.description, 'Camiseta branca GG');
    });
  });
}
