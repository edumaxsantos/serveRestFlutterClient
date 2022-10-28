import 'package:serve_rest_flutter_client/src/features/products/models/product_model.dart';

class ProductsModel {
  final List<ProductModel> produtos;
  final int quantidade;

  ProductsModel({
    required this.produtos,
    required this.quantidade,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    final products = List<Map<String, dynamic>>.from(json['produtos']);
    final formatted = products
        .map<ProductModel>(
            (Map<String, dynamic> product) => ProductModel.fromJson(product))
        .toList();
    return ProductsModel(
      quantidade: json['quantidade'],
      produtos: formatted,
    );
  }
}
