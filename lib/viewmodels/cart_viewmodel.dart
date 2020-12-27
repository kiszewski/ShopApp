import 'package:shopApp/models/item_cart_model.dart';
import 'package:shopApp/models/product_model.dart';
import 'package:shopApp/repository/user_repository.dart';

class CartViewModel {
  final UserRepository _userRepository;

  CartViewModel(this._userRepository);

  Stream<List<ItemCartModel>> get cart => _userRepository.getCart();

  Future addInCart(ProductModel product) async {
    ItemCartModel item = ItemCartModel.fromJson(
      product.id,
      product.toJson(),
    );
    item.qtd = 1;

    await _userRepository.addInCart(item);
  }

  Future removeFromCart(ItemCartModel product) async =>
      await _userRepository.removeFromCart(product);

  Future increaseQtdItem(ItemCartModel product) async {
    product.qtd++;
    await _userRepository.updateQtdItemCart(product);
  }

  Future decreaseQtdItem(ItemCartModel product) async {
    if (product.qtd > 1) {
      product.qtd--;
      await _userRepository.updateQtdItemCart(product);
    }
  }

  double totalInCart(List<ItemCartModel> cart) => cart.fold(
        0,
        (previousValue, product) =>
            previousValue + (product.price * product.qtd),
      );
}
