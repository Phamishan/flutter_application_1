import 'package:flutter/material.dart';
import 'package:flutter_application_1/register.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(),
          TextField(),
          TextButton(onPressed: () {}, child: Text("log in")),
          TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Register();
                }));
              },
              child: Text("opret en konto"))
        ],
      ),
    );
  }
}
