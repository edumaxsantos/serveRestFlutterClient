import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serve_rest_flutter_client/src/features/login/models/token_model.dart';
import 'package:serve_rest_flutter_client/src/features/products/models/product_model.dart';
import 'package:serve_rest_flutter_client/src/features/products/services/products_service.dart';
import 'package:serve_rest_flutter_client/src/shared/widgets/basic_input_field_widget.dart';

class CreateProductPage extends StatefulWidget {
  const CreateProductPage({super.key});

  @override
  State<CreateProductPage> createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  final Map<String, dynamic> _form = {};
  TokenModelNotifier _valueListener = TokenModelNotifier();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Produto'),
        actions: [
          Consumer<TokenModelNotifier>(
            builder: (context, value, child) {
              return IconButton(
                onPressed: _isFormDataValid() ? _saveForm(value.token) : null,
                icon: const Icon(Icons.check),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            child: Column(
              children: [
                BasicInputFieldWidget(
                  onChanged: (value) {
                    setState(() {
                      _form.update('nome', (oldValue) => value,
                          ifAbsent: (() => value));
                    });
                  },
                  label: 'Nome',
                ),
                const SizedBox(
                  height: 20,
                ),
                BasicInputFieldWidget(
                  onChanged: (value) {
                    setState(() {
                      _form.update('descricao', (oldValue) => value,
                          ifAbsent: (() => value));
                    });
                  },
                  label: 'Descrição',
                ),
                const SizedBox(
                  height: 20,
                ),
                BasicInputFieldWidget(
                  textInputType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _form.update('preco', (oldValue) => value,
                          ifAbsent: (() => value));
                    });
                  },
                  label: 'Preço',
                ),
                const SizedBox(
                  height: 20,
                ),
                BasicInputFieldWidget(
                  textInputType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _form.update('quantidade', (oldValue) => value,
                          ifAbsent: (() => value));
                    });
                  },
                  label: 'Quantidade',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _saveForm(String token) {
    return () async {
      _form.update('preco', (value) => int.tryParse(value) ?? value);
      _form.update('quantidade', (value) => int.tryParse(value) ?? value);
      final response = await ProductsService()
          .createProduct(ProductModel.fromJson(_form), token);
      if (response.statusCode == 201) {
        _showSnackbar(response.body!['message'], Colors.green);
        Navigator.of(context).pop();
        return;
      }
      _showSnackbar(response.body!['message'], Colors.red);
    };
  }

  _showSnackbar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Produto criado com sucesso",
          selectionColor: color,
        ),
      ),
    );
  }

  bool _isFormDataValid() {
    return _form.isNotEmpty &&
        _form.containsKey('nome') &&
        _form['nome']!.isNotEmpty &&
        _form.containsKey('preco') &&
        _form['preco']!.isNotEmpty &&
        _form.containsKey('descricao') &&
        _form['descricao']!.isNotEmpty &&
        _form.containsKey('quantidade') &&
        _form['quantidade']!.isNotEmpty;
  }
}
