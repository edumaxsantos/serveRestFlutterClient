import 'package:provider/provider.dart';
import 'package:serve_rest_flutter_client/src/features/home/home_page.dart';
import 'package:serve_rest_flutter_client/src/features/login/models/token_model.dart';
import 'package:serve_rest_flutter_client/src/features/login/services/login_service.dart';
import 'package:serve_rest_flutter_client/src/shared/widgets/basic_input_field_widget.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey _formKey = GlobalKey<FormState>();

  String _email = '';
  String _password = '';

  _navigate() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: ((context) => HomePage())));
  }

  _showSnackbar({required Map<String, dynamic> body, required int statusCode}) {
    String message = 'Undefined message';
    if (body.containsKey('email')) {
      message = body['email'];
    } else if (body.containsKey('message')) {
      message = body['message'];
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("$statusCode - $message")),
    );
  }

  _performLogin() async {
    final response =
        await LoginService().login(email: _email, password: _password);

    if (response.statusCode == 200) {
      Provider.of<TokenModelNotifier>(context, listen: false)
          .updateToken(response.body!['authorization']);
      _navigate();
    } else {
      _showSnackbar(
        body: response.body!,
        statusCode: response.statusCode,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildEmailTextField(),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildPasswordTextField(),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: _email.isEmpty || _password.isEmpty
                        ? null
                        : _performLogin,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildEmailTextField() {
    return BasicInputFieldWidget(
      onChanged: (value) => setState(() {
        _email = value;
      }),
      label: 'Email',
    );
  }

  _buildPasswordTextField() {
    return BasicInputFieldWidget(
      onChanged: (value) => setState(() {
        _password = value;
      }),
      label: 'Password',
      isPassword: true,
    );
  }
}
