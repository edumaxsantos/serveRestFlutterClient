import 'package:flutter/cupertino.dart';

class TokenModelNotifier extends ChangeNotifier {
  String token;
  TokenModelNotifier({this.token = ''});

  updateToken(String token) {
    this.token = token;
    notifyListeners();
  }
}
