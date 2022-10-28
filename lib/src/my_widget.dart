import 'package:provider/provider.dart';
import 'package:serve_rest_flutter_client/src/features/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:serve_rest_flutter_client/src/features/login/models/token_model.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TokenModelNotifier(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginPage(),
      ),
    );
  }
}
