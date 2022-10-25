import 'package:api_calling_test/src/features/products/products_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final Map<String, Widget> routes = {'Produtos': const ProductsPage()};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _button(text: 'Produtos', context: context),
              _button(text: 'Usuários', context: context),
              _button(text: 'Carrinhos', context: context),
            ],
          ),
        ),
      ),
    );
  }

  _button({required String text, required BuildContext context}) {
    return ElevatedButton(
      onPressed: !routes.containsKey(text)
          ? null
          : () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => routes[text]!,
              ));
            },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
