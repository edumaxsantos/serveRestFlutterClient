import 'dart:convert';

import 'package:serve_rest_flutter_client/src/features/products/models/products_model.dart';
import 'package:serve_rest_flutter_client/src/features/products/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<ProductsModel> fetchProducts() async {
  final response = await http.get(Uri.parse('https://serverest.dev/produtos'));

  if (response.statusCode == 200) {
    debugPrint('got status 200');
    final products = ProductsModel.fromJson(jsonDecode(response.body));
    debugPrint('Quantidade ${products.quantidade}');
    return products;
  } else {
    throw Exception('Failed to load products');
  }
}

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late Future<ProductsModel> products;

  @override
  void initState() {
    super.initState();
    products = fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  products = fetchProducts();
                });
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              FutureBuilder<ProductsModel>(
                future: products,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text('no data');
                  }

                  if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  debugPrint('${snapshot.data!.quantidade}');
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.quantidade,
                      itemBuilder: (context, index) {
                        final produto = snapshot.data!.produtos[index];
                        return ListTile(
                          title: Text(produto.nome),
                          leading: Text(produto.id),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailPage(product: produto),
                            ));
                          },
                        );
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
