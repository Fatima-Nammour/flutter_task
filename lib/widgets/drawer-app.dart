import 'package:flutter/material.dart';
import 'package:flutter_task/models/user.dart';
import 'package:hive/hive.dart';

import 'button.dart';

class DrawerApp extends StatelessWidget {
  const DrawerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 50.0,
      child: Column(
        children: [
          InkWell(
            child: Center(
              child: Text('log out'),
            ),
            onTap: () async {
              await showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Are you sure to logout?'),
                      actions: [
                        ButtonWidget(
                          onPress: () {
                            Hive.box<User>('user').getAt(0)!.isLogged = false;
                            Navigator.of(context).pop();
                          },
                          textButton: 'OK',
                        ),
                      ],
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}
