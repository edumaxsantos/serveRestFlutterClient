import 'package:flutter/material.dart';
import 'package:serve_rest_flutter_client/src/features/products/services/products_service.dart';
import 'package:serve_rest_flutter_client/src/features/products/widgets/product_form_widget.dart';

class CreateProductPage extends StatelessWidget {
  const CreateProductPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ProductFormWidget(
      performOperation: ProductsService().createProduct,
      title: 'Criar Produto',
    );
  }
}
