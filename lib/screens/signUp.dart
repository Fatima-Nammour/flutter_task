import 'package:flutter/material.dart';
import 'package:flutter_task/widgets/button.dart';
import 'package:flutter_task/widgets/imageProfile.dart';
import 'package:flutter_task/widgets/textField.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            ListView(
              children: [
                ImageProfile(),
                TextFieldWidget(
                  labelString: 'Name',
                  icon: Icons.person_outline,
                ),
                TextFieldWidget(
                  labelString: 'Full Name',
                  icon: Icons.person_outline,
                ),
                TextFieldWidget(
                  labelString: 'Password',
                  icon: Icons.lock_outline,
                ),
                TextFieldWidget(
                  labelString: 'Mobile Number',
                  icon: Icons.phone_android_outlined,
                ),
                TextFieldWidget(
                  labelString: 'City',
                  icon: Icons.location_city_outlined,
                ),
                //SignUp Button
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ButtonWidget(
                    textButton: 'Sign Up',
                    onPress: () {
                      print('sign up');
                      Navigator.pushReplacementNamed(context, 'Products');
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
