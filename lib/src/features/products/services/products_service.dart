import 'package:serve_rest_flutter_client/src/features/products/models/products_model.dart';
import 'package:serve_rest_flutter_client/src/infra/request.dart';

class ProductsService {
  Future<ProductsModel> fetchProducts() async {
    final response = await Request().get(path: 'produtos');
    if (response.statusCode == 200) {
      final products = ProductsModel.fromJson(response.body!);
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
