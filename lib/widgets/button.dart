import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/component/colorsUsed.dart';

class ButtonWidget extends StatelessWidget {
  final String? textButton;
  final Function? onPress;

  ButtonWidget({this.textButton, this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(col2),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(15.0),
              ),
            ),
            elevation: MaterialStateProperty.all(5.0),
            shadowColor: MaterialStateProperty.all<Color>(col1),
          ),
          child: Text(
            textButton!,
            style: TextStyle(
                color: col1, fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
          onPressed: () {
            onPress!();
          }),
    );
  }
}
