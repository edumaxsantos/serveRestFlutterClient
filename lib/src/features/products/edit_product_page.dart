import 'package:flutter/material.dart';
import 'package:serve_rest_flutter_client/src/features/products/models/product_model.dart';
import 'package:serve_rest_flutter_client/src/features/products/services/products_service.dart';
import 'package:serve_rest_flutter_client/src/features/products/widgets/product_form_widget.dart';

class EditProductPage extends StatelessWidget {
  ProductModel product;
  EditProductPage({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return ProductFormWidget(
      title: 'Editar produto',
      performOperation: ProductsService().editProduct,
      productModel: product,
    );
  }
}
