import 'package:flutter/material.dart';
import 'package:flutter_task/component/colorsUsed.dart';

class BottomNavigationBarUsed extends StatelessWidget {
  final int index;
  const BottomNavigationBarUsed(this.index);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) {
        print('$index');
        switch (index) {
          case (0):
            {
              Navigator.pushReplacementNamed(context, 'Products');
            }
            break;
          case (1):
            {
              Navigator.pushReplacementNamed(context, 'ShoppingCart');
            }
            break;
          default:
            {
              Navigator.pushReplacementNamed(context, 'Products');
            }
        }
      },
      backgroundColor: Colors.white,
      iconSize: 30.0,
      showSelectedLabels: true,
      currentIndex: index,
      selectedItemColor: col2,
      unselectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.shop_outlined),
          label: '',
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined), label: ''),
      ],
    );
  }
}
