import 'package:flutter/material.dart';
import 'package:flutter_task/models/product.dart';
import 'package:flutter_task/models/shopping-cart.dart';
import 'package:flutter_task/screens/login.dart';
import 'package:flutter_task/screens/proucts.dart';
import 'package:flutter_task/screens/shoppingCartScreen.dart';
import 'package:flutter_task/screens/signUp.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/shopping-cart.dart';
import 'models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  await Hive.openBox<Product>('products'); //Products Box
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<User>('user'); //User Box
  Hive.registerAdapter(ShoppingCartAdapter());
  await Hive.openBox<ShoppingCart>('ShoppingCart'); //User Box

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    Widget widgetHome() {
      if (Hive.box<User>('user').getAt(0)!.isSignup!)
        return SignUpScreen();
      else if (Hive.box<User>('user').getAt(0)!.isLogged!)
        return Login();
      else
        return Products();
    }

    return MaterialApp(
      routes: {
        'SignUp': (BuildContext context) => SignUpScreen(),
        'Login': (BuildContext context) => Login(),
        'Products': (BuildContext context) => Products(),
        'ShoppingCart': (BuildContext context) => ShoppingCartPage(),
      },
      debugShowCheckedModeBanner: false,
      home: widgetHome(),
    );
  }
}
