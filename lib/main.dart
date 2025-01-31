import 'package:flutter/material.dart';
import 'package:flutter_application_1/animals.dart';
import 'package:flutter_application_1/auth.dart';
import 'package:flutter_application_1/login.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => Auth(),
        builder: (context, _) {
          final session = context.watch<Auth>();
          switch (session.status) {
            case LoggedIn(token: final token):
              return Animals(token: token);
            default:
              return Login();
          }
        },
      ),
    );
  }
}
