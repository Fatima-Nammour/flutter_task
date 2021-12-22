import 'package:flutter/material.dart';
import 'package:flutter_task/widgets/bottom_navigation_bar.dart';
import 'package:flutter_task/widgets/productCard.dart';

class Products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: BottomNavigationBarUsed(0),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          ProductCard(
            name: 'Name',
            imageUrl: 'assets/images/shopping_app.png',
            description: 'description',
            price: '100',
          ),
          ProductCard(
            name: 'Name',
            imageUrl: 'assets/images/shopping_app.png',
            description: 'description',
            price: '100',
          ),
        ],
      ),
    ));
  }
}
