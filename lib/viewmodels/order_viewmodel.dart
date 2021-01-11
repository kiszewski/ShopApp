import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopApp/models/item_cart_model.dart';
import 'package:shopApp/models/order_model.dart';
import 'package:shopApp/repository/user_repository.dart';

class OrderViewModel {
  final UserRepository _userRepository;

  OrderViewModel(this._userRepository);

  Stream<List<OrderModel>> get orders => _userRepository.getOrders();

  Future checkOut(List<ItemCartModel> productsInCart) async {
    OrderModel order = OrderModel(
      date: Timestamp.now(),
      products: productsInCart,
    );

    await _userRepository.addOrder(order);

    productsInCart.forEach((product) async {
      await _userRepository.removeFromCart(product);
    });
  }

  double totalOrder(OrderModel order) {
    return order.products.fold(
      0,
      (previousValue, product) => previousValue + (product.price * product.qtd),
    );
  }
}
