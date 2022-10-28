import 'dart:io';
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

  Future<Response> createProduct({
    required ProductModel product,
    required String token,
  }) async {
    final response = await request.post(
      path: 'produtos',
      body: product.toJson(),
      headers: {
        HttpHeaders.authorizationHeader: token,
      },
    );
    return response;
  }

  Future<Response> deleteProduct({
    required ProductModel product,
    required String token,
  }) async {
    return await request.delete(path: 'produtos/${product.id}', headers: {
      HttpHeaders.authorizationHeader: token,
    });
  }

  Future<Response> editProduct(
      {required ProductModel product, required String token}) async {
    final productWithoutId = {...product.toJson()};
    productWithoutId.remove('id');
    return await request
        .put(path: 'produtos/${product.id}', body: productWithoutId, headers: {
      HttpHeaders.authorizationHeader: token,
    });
  }
}
