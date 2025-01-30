import 'package:flutter/material.dart';
import 'package:flutter_application_1/client.dart';
import 'package:provider/provider.dart';

class RegisterRequest extends ChangeNotifier {
  Response status = Unset();

  void register(String username, String password) async {
    status = Loading();
    notifyListeners();

    var result = await Client().register(username, password);

    status = switch (result) {
      SuccessResult() => Success(),
      ErrorResult(message: final message) => Error(message: message)
    };
    notifyListeners();
  }
}

sealed class Response {}

final class Unset extends Response {}

final class Loading extends Response {}

final class Success extends Response {}

final class Error extends Response {
  final String message;
  Error({required this.message});
}

class Register extends StatelessWidget {
  Register({super.key});

  final username = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (BuildContext context) {
          return RegisterRequest();
        },
        builder: (context, child) {
          var registerRequest = context.watch<RegisterRequest>();
          var statusText = "";
          switch (registerRequest.status) {
            case Unset():
              statusText = "";
            case Loading():
              statusText = "Loading";
            case Success():
              statusText = "Success";
            case Error(message: final message):
              statusText = message;
          }

          return Column(
            children: [
              TextField(
                controller: username,
              ),
              TextField(
                controller: password,
              ),
              TextButton(
                  onPressed: () {
                    registerRequest.register(username.text, password.text);
                  },
                  child: Text("sign up")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("login side")),
              Text(statusText)
            ],
          );
        },
      ),
    );
  }
}
