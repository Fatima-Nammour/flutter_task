import 'package:flutter/material.dart';
import 'package:flutter_task/component/colorsUsed.dart';

class TextFieldWidget extends StatelessWidget {
  final IconData? icon;
  final InputDecoration? decoration;
  final String? labelString;
  final TextEditingController? textController;
  final Function? onChange;
  final String? validator;

  TextFieldWidget({
    this.icon,
    this.decoration,
    this.labelString,
    this.textController,
    this.onChange,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      child: Opacity(
        opacity: 0.6,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: col2,
                blurRadius: 6,
                offset: Offset(5, 4),
              ),
            ],
            borderRadius: BorderRadius.circular(
              4.0,
            ),
          ),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: TextFormField(
              controller: textController,
              onChanged: (text) {
                onChange!();
              },
              validator: (String? value) {
                return (value!.trim().length == 0) ? validator : null;
              },
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                labelText: labelString,
                labelStyle: TextStyle(color: Colors.white, fontSize: 15.0),
                prefixIcon: Icon(
                  icon,
                  color: Colors.white,
                  size: 25.0,
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide(
                      color: col1,
                    )),
                fillColor: col1,
                filled: true,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
