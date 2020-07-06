import 'package:blog_app/app/home_page.dart';
import 'package:blog_app/authentication/auth.dart';
import 'package:blog_app/services/database_services.dart';
import 'package:blog_app/signin/register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthService>(
      create: (context) => Auth(),
      child: Provider<DatabaseServices>(
        create: (_) => Database(),
        child: HomePage(),
      ),
    );
  }
}
