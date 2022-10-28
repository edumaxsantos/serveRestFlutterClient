import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:serve_rest_flutter_client/src/features/login/models/token_model.dart';
import 'package:serve_rest_flutter_client/src/features/products/create_product_page.dart';
import 'package:serve_rest_flutter_client/src/features/products/edit_product_page.dart';
import 'package:serve_rest_flutter_client/src/features/products/models/product_model.dart';
import 'package:serve_rest_flutter_client/src/features/products/models/products_model.dart';
import 'package:serve_rest_flutter_client/src/features/products/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:serve_rest_flutter_client/src/features/products/services/products_service.dart';
import 'package:serve_rest_flutter_client/src/shared/widgets/show_snackbar.dart';

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
                  .then((value) => _updateProducts());
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              _updateProducts();
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
                  final data = snapshot.data!;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: data.quantidade,
                      itemBuilder: (context, index) {
                        final produto = data.produtos[index];
                        return _listViewBuilder(context, produto);
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

  _listViewBuilder(context, ProductModel produto) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          Consumer<TokenModelNotifier>(
            builder: (context, value, child) {
              return SlidableAction(
                onPressed: (context) =>
                    _showDeleteDialog(produto: produto, token: value.token),
                icon: Icons.delete,
                label: 'Apagar',
                autoClose: true,
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
              );
            },
          ),
          SlidableAction(
            onPressed: (context) {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: ((context) => EditProductPage(
                            product: produto,
                          ))))
                  .then((value) => _updateProducts());
            },
            icon: Icons.edit,
            label: 'Editar',
            autoClose: true,
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
          ),
        ],
      ),
      child: ListTile(
        key: Key(produto.id!),
        title: Text(produto.nome),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductDetailPage(product: produto),
          ));
        },
      ),
    );
  }

  _showDeleteDialog({required ProductModel produto, required String token}) {
    return showDialog(
      context: context,
      builder: ((context) {
        return AlertDialog(
          title: const Text('Deseja continuar?'),
          content:
              Text('Está prestes a apagar ${produto.nome}. Está certo disso?'),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop('Cancelar'),
                child: const Text('Cancelar')),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop('Apagar');
                final response = await widget.service
                    .deleteProduct(product: produto, token: token);
                if (mounted) {
                  if (response.statusCode == 200) {
                    showSnackbar(
                        context, response.body!['message'], Colors.green);
                    _updateProducts();
                  } else {
                    showSnackbar(
                        context, response.body!['message'], Colors.red);
                  }
                }
              },
              child: const Text('Apagar'),
            ),
          ],
        );
      }),
    );
  }

  _updateProducts() {
    setState(() {
      products = widget.service.fetchProducts();
    });
  }
}
