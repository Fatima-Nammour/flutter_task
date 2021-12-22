import 'package:flutter/material.dart';
import 'package:flutter_task/component/colorsUsed.dart';

class ImageProfile extends StatelessWidget {
  const ImageProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Opacity(
        opacity: 0.6,
        child: CircleAvatar(
          backgroundColor: col1,
          radius: 65.0,
          child: Icon(
            Icons.person_outline,
            size: 40.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
