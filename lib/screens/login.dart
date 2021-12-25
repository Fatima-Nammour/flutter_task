import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_task/component/spinKit.dart';
import 'package:flutter_task/models/user.dart';
import 'package:flutter_task/widgets/button.dart';
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
      await showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Please fill data '),
              actions: [
                ButtonWidget(
                  onPress: () {
                    Navigator.of(context).pop();
                  },
                  textButton: 'OK',
                ),
              ],
            );
          });
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
