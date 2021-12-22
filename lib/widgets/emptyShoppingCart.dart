import 'package:flutter/material.dart';
import 'package:flutter_task/component/colorsUsed.dart';

class EmptyShoppingCartPage extends StatelessWidget {
  const EmptyShoppingCartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: col6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Image.asset(
              'assets/images/empty_cart.png',
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.height * 0.6,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.5),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: col1,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(4.0)),
              child: Text(
                'No products here! ',
                style: TextStyle(color: col1, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
