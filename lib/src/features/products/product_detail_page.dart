import 'package:serve_rest_flutter_client/src/features/products/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductModel product;
  const ProductDetailPage({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.nome),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _text('ID: ${product.id}'),
              const SizedBox(
                height: 10,
              ),
              _text('Preço: ${product.preco}'),
              const SizedBox(
                height: 10,
              ),
              _text('Descrição: ${product.descricao}'),
              const SizedBox(
                height: 10,
              ),
              _text('Quantidade: ${product.quantidade}')
            ],
          ),
        ),
      ),
    );
  }

  _text(String data) {
    return Text(
      data,
      style: TextStyle(
        fontSize: 22,
      ),
    );
  }
}
