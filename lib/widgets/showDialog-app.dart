import 'package:flutter/material.dart';

import 'button.dart';

Future<void> showDialogApp(context, text) async {
  return await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$text'),
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
}
