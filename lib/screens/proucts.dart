import 'package:flutter/material.dart';
import 'package:flutter_task/component/notificationService/NotificationService.dart';
import 'package:flutter_task/models/product.dart';
import 'package:flutter_task/models/shopping-cart.dart';
import 'package:flutter_task/models/user.dart';
import 'package:flutter_task/widgets/bottom_navigation_bar.dart';
import 'package:flutter_task/widgets/drawer-app.dart';
import 'package:flutter_task/widgets/productCard.dart';
import 'package:flutter_task/widgets/productCardDetailed.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:timezone/data/latest.dart' as tz;

class Products extends StatefulWidget {
  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  void initState() {
    tz.initializeTimeZones();
    super.initState();
  }

  @override
  void dispose() {
    //Hive.box('products').close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      drawer: DrawerApp(),
      bottomNavigationBar: BottomNavigationBarUsed(0),
      backgroundColor: Colors.white,
      body: ValueListenableBuilder<Box<Product>>(
        valueListenable: Hive.box<Product>('products').listenable(),
        builder: (context, box, _) {
          final products =
              Hive.box<Product>('products').values.toList().cast<Product>();
          print(box.values.length);
          print('${products.length}');

          return ListView.builder(
            itemBuilder: (BuildContext context, int index) => ProductCard(
              price: products[index].price,
              name: products[index].name,
              imageUrl: products[index].imageUrl,
              description: products[index].description,
              rate: products[index].rate,
              marketName: products[index].marketName,
              marketAddress: products[index].marketAddress,
              onPressDetail: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => ProductCardDetailed(
                              price: products[index].price,
                              name: products[index].name,
                              imageUrl: products[index].imageUrl,
                              description: products[index].description,
                              rate: products[index].rate,
                              marketName: products[index].marketName,
                              marketAddress: products[index].marketAddress,
                            )));
              },
              onPressAdd: () {
                Hive.box<ShoppingCart>('ShoppingCart').add(
                  ShoppingCart()
                    ..name = products[index].name
                    ..id = index
                    ..price = products[index].price
                    ..rate = products[index].rate
                    ..imageUrl = products[index].imageUrl
                    ..description = products[index].description
                    ..marketName = products[index].marketName
                    ..marketAddress = products[index].marketAddress,
                );
                Hive.box<User>('user').getAt(0)!.isEmptyShoppingCart = false;
                NotificationService().showNotification(
                  0,
                  'Shopping Cart',
                  'new product has been added successfully”',
                );
              },
            ),
            itemCount: products.length,
          );
        },
      ),
    ));
  }
}
