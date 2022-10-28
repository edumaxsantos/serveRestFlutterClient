import 'package:serve_rest_flutter_client/src/features/products/create_product_page.dart';
import 'package:serve_rest_flutter_client/src/features/products/models/products_model.dart';
import 'package:serve_rest_flutter_client/src/features/products/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:serve_rest_flutter_client/src/features/products/services/products_service.dart';

class ProductsPage extends StatefulWidget {
  final service = ProductsService();
  ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late Future<ProductsModel> products;

  @override
  void initState() {
    super.initState();
    products = widget.service.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(
                    MaterialPageRoute(
                      builder: ((context) => const CreateProductPage()),
                    ),
                  )
                  .then((value) => setState(() {
                        products = widget.service.fetchProducts();
                      }));
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                products = widget.service.fetchProducts();
              });
            },
            icon: const Icon(Icons.refresh),
          ),
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
                    return const Text('no data');
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
                          key: Key(produto.id!),
                          title: Text(produto.nome),
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
