import 'package:flutter/material.dart';
import 'package:flutter_task/widgets/button.dart';
import 'package:flutter_task/widgets/textField.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                TextFieldWidget(
                  labelString: 'Name',
                  icon: Icons.person_outline,
                ),
                TextFieldWidget(
                  labelString: 'Password',
                  icon: Icons.lock_outline,
                ),
                //SignUp Button
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ButtonWidget(
                    textButton: 'Log in',
                    onPress: () {
                      print('Login');
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
