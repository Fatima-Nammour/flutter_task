import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_task/component/spinKit.dart';
import 'package:flutter_task/models/product.dart';
import 'package:flutter_task/models/user.dart';
import 'package:flutter_task/widgets/button.dart';
import 'package:flutter_task/widgets/showDialog-app.dart';
import 'package:flutter_task/widgets/textField.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController? nameController = TextEditingController();

  final TextEditingController? passwordController = TextEditingController();

  var statusCode;

  bool isLoading = false;

  var response = http.Response("Error", 100);

  void loginButton(context) async {
    if (nameController!.text.isEmpty || passwordController!.text.isEmpty) {
      await showDialogApp(context, 'Please fill data');
    } else {
      await loginRequest(
          nameController!.text, passwordController!.text, context);
    }
  }

  Future<http.Response> loginRequest(
      String name, String pass, BuildContext context) async {
    try {
      var uri =
          Uri.parse('https://flutter-task-hala-tech.herokuapp.com/user_login');
      Map data = {"userName": name, "password": pass};
      var body = json.encode(data);
      print('loading');
      setState(() {
        isLoading = true;
      });
      var response = await http.post(uri,
          headers: {"Content-Type": "application/json"}, body: body);
      print('return from request');
      setState(() {
        isLoading = false;
      });

      print("${response.statusCode}");
      statusCode = response.statusCode;
      var resBody = json.decode(response.body);
      if (response.statusCode == 404) {
        print('user not found');
        print("${resBody["message"]} ");
      } else if (statusCode == 200) {
        print('log in successfully');
        Hive.box<User>('user').getAt(0)!.isLogged = true;
        Navigator.pushReplacementNamed(context, 'Products');
      }
      return response;
    } catch (e) {
      return response;
    }
  }

  Future<http.Response> getProducts() async {
    try {
      var uri =
          Uri.parse('https://flutter-task-hala-tech.herokuapp.com/products');
      print('begin  request');
      var response = await http.get(uri);
      print('return from request');
      var body = json.decode(response.body);
      print('$body');
      print("${response.statusCode}");
      statusCode = response.statusCode;
      if (statusCode == 200) {
        print('Successful');
        for (int i = 0; i < body.length; i++) {
          print('${body["products"][2]["market"]["address"]}');
          print('${body["products"][i]["name"]}');
          //Add product into the box
          Hive.box<Product>('products').add(Product()
            ..name = body["products"][i]["name"]
            ..id = int.parse(body["products"][i]["id"])
            ..price = body["products"][i]["price"].toString()
            ..imageUrl = body["products"][i]["imageUrl"]
            ..rate = body["products"][i]["rate"].toString()
            ..description = body["products"][i]["description"]
            ..marketName = body["products"][i]["market"]["name"]
            ..marketAddress = body["products"][i]["market"]["address"]);
          print('${Hive.box<Product>('products').values}');
          print('${Hive.box<Product>('products').keys}');
        }
      }
      return response;
    } catch (e) {
      print('catch $e');
      await showDialogApp(context,
          'Something wrong while loading the products!, please check your connection and try again');
      setState(() {
        isLoading = false;
      });
      return response;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0),
                  child: Center(
                    child: Image.asset(
                      'assets/images/shopping_app.png',
                      fit: BoxFit.contain,
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width * 0.5,
                    ),
                  ),
                ),
                //textField name
                TextFieldWidget(
                  labelString: 'Name',
                  icon: Icons.person_outline,
                  textController: nameController,
                  onChange: () {
                    print(nameController!.text);
                  },
                ),
                //textField password
                TextFieldWidget(
                  labelString: 'Password',
                  icon: Icons.lock_outline,
                  textController: passwordController,
                  onChange: () {
                    print(passwordController!.text);
                  },
                ),
                //SignUp Button
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ButtonWidget(
                    textButton: 'Log in',
                    onPress: () {
                      loginButton(context);
                    },
                  ),
                )
              ],
            ),
            if (isLoading)
              Opacity(
                opacity: 0.4,
                child: Container(color: Colors.black, child: spinKit),
              )
          ],
        ),
      ),
    );
  }
}
