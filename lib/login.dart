import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth.dart';
import 'package:flutter_application_1/register.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final username = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: username,
          ),
          TextField(controller: password),
          TextButton(
              onPressed: () {
                final auth = context.read<Auth>();
                auth.login(username.text, password.text);
              },
              child: Text("log in")),
          TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Register();
                }));
              },
              child: Text("opret en konto")),
          Consumer<Auth>(
            builder: (_, data, __) {
              if (!data.status.shouldShow()) return Text("");
              return Text(data.status.toString());
            },
          ),
        ],
      ),
    );
  }
}
