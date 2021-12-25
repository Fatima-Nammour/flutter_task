import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_task/component/colorsUsed.dart';
import 'package:flutter_task/models/product.dart';
import 'package:flutter_task/models/user.dart';
import 'package:flutter_task/widgets/button.dart';
import 'package:flutter_task/widgets/imageProfile.dart';
import 'package:flutter_task/widgets/textField.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController? nameController = TextEditingController();
  final TextEditingController? passwordController = TextEditingController();
  final TextEditingController? fullNameController = TextEditingController();
  final TextEditingController? cityController = TextEditingController();
  final TextEditingController? numberController = TextEditingController();
  var statusCode;
  var response = http.Response("Error", 100);
  var reBody;
  bool isLoading = false;
  bool loadingProducts = false;

  @override
  void dispose() {
    //Hive.box('user').close();
    super.dispose();
  }

  Future<void> signUp() async {
    if (nameController!.text.isEmpty ||
        fullNameController!.text.isEmpty ||
        passwordController!.text.isEmpty ||
        cityController!.text.isEmpty ||
        numberController!.text.isEmpty) {
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
      await signUpRequest(
          nameController!.text,
          passwordController!.text,
          fullNameController!.text,
          numberController!.text,
          cityController!.text);
      print('back from Sign up ');
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
      return response;
    }
  }

  Future<http.Response> signUpRequest(String name, String pass, String fullName,
      String phoneNumber, String city) async {
    try {
      var uri = Uri.parse(
          'https://flutter-task-hala-tech.herokuapp.com/user_register');
      Map data = {
        "userName": name,
        "password": pass,
        "fullName": fullName,
        "phoneNumber": phoneNumber,
        "city": city,
      };
      var body = json.encode(data);
      print('request sent');
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
      if (response.statusCode == 404) {
        print('user not found');
      } else if (statusCode == 409) {
        reBody = json.decode(response.body);
        //user already exist
        print("${reBody["message"]}");
        await showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('User already exist '),
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
      } else if (statusCode == 200) {
        print('Sign up successfully');
        Hive.box<User>('user').add(
          User()
            ..name = nameController!.text.trim()
            ..fullName = fullNameController!.text.trim()
            ..password = passwordController!.text.trim()
            ..number = numberController!.text.trim()
            ..city = cityController!.text.trim()
            ..isEmptyShoppingCart = true
            ..isLogged = true
            ..isSignup = true,
        );
        setState(() {
          loadingProducts = true;
        });
        await getProducts();
        setState(() {
          loadingProducts = false;
        });
        Navigator.pushReplacementNamed(context, 'Products');
      }
      return response;
    } catch (e) {
      print('catch $e');
      return response;
    }
  }

  @override
  Widget build(BuildContext context) {
    var spinKit = SpinKitRotatingCircle(
      color: col2,
      size: 50.0,
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            ListView(
              children: [
                ImageProfile(),
                //textField name
                TextFieldWidget(
                  labelString: 'Name',
                  icon: Icons.person_outline,
                  textController: nameController,
                  onChange: () {
                    print(nameController!.text);
                  },
                  validator: 'Please enter your name',
                ),
                //textField fullName
                TextFieldWidget(
                  labelString: 'Full Name',
                  icon: Icons.person_outline,
                  textController: fullNameController,
                  onChange: () {
                    print(fullNameController!.text);
                  },
                  validator: 'Please enter full name',
                ),
                //textField password
                TextFieldWidget(
                  labelString: 'Password',
                  icon: Icons.lock_outline,
                  textController: passwordController,
                  onChange: () {
                    print(passwordController!.text);
                  },
                  validator: 'Please enter your password',
                ),
                //textField number
                TextFieldWidget(
                  labelString: 'Mobile Number',
                  icon: Icons.phone_android_outlined,
                  textController: numberController,
                  onChange: () {
                    print(numberController!.text);
                  },
                  validator: 'Please enter your number',
                ),
                //textField city
                TextFieldWidget(
                  labelString: 'City',
                  icon: Icons.location_city_outlined,
                  textController: cityController,
                  onChange: () {
                    print(cityController!.text);
                  },
                  validator: 'Please enter your city',
                ),
                //SignUp Button
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ButtonWidget(
                    textButton: 'Sign Up',
                    onPress: () async {
                      await signUp();
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
