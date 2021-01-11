import 'package:shopApp/models/product_model.dart';
import 'package:shopApp/repository/user_repository.dart';

class FavoritesViewModel {
  final UserRepository _userRepository;

  FavoritesViewModel(this._userRepository);

  Future toggleFavoriteProduct(ProductModel product) async =>
      await _userRepository.toggleFavoriteProduct(product);

  Stream<List<ProductModel>> get favorites => _userRepository.getFavorites();
}
