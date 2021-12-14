import 'package:cocktail_app/ui/router.dart' as foo;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cocktail_app/core/services/authentication_service.dart';
import 'package:cocktail_app/locator.dart';
import 'core/models/user.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>(
      initialData: User.initial(),
      create: (context) =>
          locator<AuthenticationService>().userController.stream,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(),
        initialRoute: 'login',
        onGenerateRoute: foo.Router.generateRoute,
      ),
    );
  }
}
