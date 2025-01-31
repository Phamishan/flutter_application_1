import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth.dart';
import 'package:flutter_application_1/client.dart';
import 'package:provider/provider.dart';

class AnimalRequest {
  Future<Response> animal(String token) async {
    var result = await Client().animal(token);

    return switch (result) {
      SuccessResult<String>(data: final animal) => Success(animal: animal),
      ErrorResult<String>(message: final message) => Error(message: message),
    };
  }
}

sealed class Response {}

class Success extends Response {
  final String animal;
  Success({required this.animal});
}

class Error extends Response {
  final String message;
  Error({required this.message});
}

class Animals extends StatefulWidget {
  const Animals({super.key, required this.token});
  final String token;

  @override
  State<StatefulWidget> createState() {
    return AnimalState();
  }
}

class AnimalState extends State<Animals> {
  late final Future<Response> animal;

  @override
  void initState() {
    animal = AnimalRequest().animal(widget.token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder(
            future: animal,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  return switch (snapshot.data) {
                    null => throw Exception("Unreachable"),
                    Success(animal: final animal) => Text("Du er en $animal!"),
                    Error(message: final message) => Text(message),
                  };
                default:
                  return Text("Loading...");
              }
            },
          ),
          TextButton(
              onPressed: () {
                final auth = context.read<Auth>();
                auth.logout();
              },
              child: Text("Log ud"))
        ],
      ),
    );
  }
}
