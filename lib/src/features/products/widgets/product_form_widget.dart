import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serve_rest_flutter_client/src/features/login/models/token_model.dart';
import 'package:serve_rest_flutter_client/src/features/products/models/product_model.dart';
import 'package:serve_rest_flutter_client/src/shared/widgets/basic_input_field_widget.dart';

class ProductFormWidget extends StatefulWidget {
  final ProductModel? productModel;
  final String title;
  final Function({required ProductModel product, required String token})
      performOperation;
  const ProductFormWidget({
    super.key,
    this.productModel,
    required this.title,
    required this.performOperation,
  });

  @override
  State<ProductFormWidget> createState() => _ProductFormWidgetState();
}

class _ProductFormWidgetState extends State<ProductFormWidget> {
  late final Map<String, dynamic> _form;

  @override
  void initState() {
    super.initState();
    if (widget.productModel != null) {
      _form = widget.productModel!.toJson();
      _form.update('preco', (value) => value.toString());
      _form.update('quantidade', (value) => value.toString());
    } else {
      _form = {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Consumer<TokenModelNotifier>(
            builder: (context, value, child) {
              return IconButton(
                onPressed:
                    _isFormDataValid() ? _sendFormToServer(value.token) : null,
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
                  initialValue: widget.productModel?.nome,
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
                  initialValue: widget.productModel?.descricao,
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
                  initialValue: widget.productModel?.preco.toString(),
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
                  initialValue: widget.productModel?.quantidade.toString(),
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

  _sendFormToServer(String token) {
    return () async {
      _form.update(
          'preco', (value) => value is String ? int.parse(value) : value);
      _form.update(
          'quantidade', (value) => value is String ? int.parse(value) : value);
      final response = await widget.performOperation(
          product: ProductModel.fromJson(_form), token: token);
      if (response.statusCode == 201 || response.statusCode == 200) {
        _showSnackbar(response.body!['message'], Colors.green);
        if (mounted) {
          Navigator.of(context).pop();
        }
        return;
      }
      _showSnackbar(response.body!['message'], Colors.red);
    };
  }

  _showSnackbar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(
          message,
        ),
      ),
    );
  }

  bool _isFormDataValid() {
    bool basicValidation = _form.isNotEmpty &&
        _form.containsKey('nome') &&
        _form['nome']!.isNotEmpty &&
        _form.containsKey('preco') &&
        _form['preco']!.isNotEmpty &&
        _form.containsKey('descricao') &&
        _form['descricao']!.isNotEmpty &&
        _form.containsKey('quantidade') &&
        _form['quantidade']!.isNotEmpty;
    if (widget.productModel != null) {
      final product = widget.productModel!;
      return basicValidation &&
          !(_form['nome'] == product.nome &&
              _form['preco'] == product.preco.toString() &&
              _form['descricao'] == product.descricao &&
              _form['quantidade'] == product.quantidade.toString());
    }
    return basicValidation;
  }
}
