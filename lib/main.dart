import 'package:flutter/material.dart';
import 'package:flutter_task/scoped_models/product-model.dart';
import 'package:flutter_task/screens/login.dart';
import 'package:flutter_task/screens/proucts.dart';
import 'package:flutter_task/screens/shoppingCart.dart';
import 'package:flutter_task/screens/signUp.dart';
//import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
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
    return ScopedModel<ProductModel>(
      model: ProductModel(),
      child: MaterialApp(
        routes: {
          'SignUp': (BuildContext context) => SignUpScreen(),
          'Login': (BuildContext context) => Login(),
          'Products': (BuildContext context) => Products(),
          'ShoppingCart': (BuildContext context) => ShoppingCart(),
        },
        debugShowCheckedModeBanner: false,
        home: SignUpScreen(),
      ),
    );
  }
}
