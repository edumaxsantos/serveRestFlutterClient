import 'package:serve_rest_flutter_client/src/features/products/models/product_model.dart';
import 'package:serve_rest_flutter_client/src/features/products/models/products_model.dart';
import 'package:serve_rest_flutter_client/src/infra/request.dart';
import 'package:serve_rest_flutter_client/src/infra/response.dart';

class ProductsService {
  final Request request = Request();
  Future<ProductsModel> fetchProducts() async {
    final response = await request.get(path: 'produtos');
    if (response.statusCode == 200) {
      final products = ProductsModel.fromJson(response.body!);
      return products;
    }
    throw Exception('Failed to load products');
  }

  Future<Response> createProduct(ProductModel product, String token) async {
    final response = await request.post(
      path: 'produtos',
      body: product.toJson(),
      headers: {'Authorization': token},
    );
    return response;
  }
}
