import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/services/auth.dart';
import 'screens/confirm_screen.dart';
import 'screens/home screen.dart';
import 'screens/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
        ],
        child:MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Установил пока LoginScreen(), чтобы можно было протестировать.
      // В рабочей версии будет в зависимости от авторизации
      // показывать LoginScreen() или HomeScreen()
      home: LoginScreen(),
      routes: {
            ConfirmScreen.routeName: (ctx) => ConfirmScreen(),
            HomeScreen.routeName: (ctx) => HomeScreen(),
          },
    ));
  }
}
