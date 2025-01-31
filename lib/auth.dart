import 'package:flutter/material.dart';
import 'package:flutter_application_1/client.dart';

class Auth extends ChangeNotifier {
  AuthStatus status = LoggedOut();

  void login(String username, String password) async {
    status = Loading();
    notifyListeners();

    var result = await Client().login(username, password);

    status = switch (result) {
      SuccessResult<String>(data: final token) => LoggedIn(token: token),
      ErrorResult<String>(message: final message) => Error(message: message),
    };
    notifyListeners();
  }

  void logout() {
    status = LoggedOut();
    notifyListeners();
  }
}

sealed class AuthStatus {
  bool shouldShow() => false;
}

final class LoggedOut extends AuthStatus {}

final class LoggedIn extends AuthStatus {
  final String token;
  LoggedIn({required this.token});
}

final class Loading extends AuthStatus {
  @override
  bool shouldShow() => true;

  @override
  String toString() => "loading...";
}

final class Error extends AuthStatus {
  final String message;
  Error({required this.message});

  @override
  bool shouldShow() => true;

  @override
  String toString() => message;
}
