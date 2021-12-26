import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_task/component/notificationService/NotificationService.dart';
import 'package:flutter_task/component/spinKit.dart';
import 'package:flutter_task/models/product.dart';
import 'package:flutter_task/models/shopping-cart.dart';
import 'package:flutter_task/widgets/bottom_navigation_bar.dart';
import 'package:flutter_task/widgets/drawer-app.dart';
import 'package:flutter_task/widgets/emptyShoppingCart.dart';
import 'package:flutter_task/widgets/productCard.dart';
import 'package:flutter_task/widgets/productCardDetailed.dart';
import 'package:flutter_task/widgets/showDialog-app.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:timezone/data/latest.dart' as tz;

class Products extends StatefulWidget {
  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  bool isLoading = false;

  var statusCode;
  var response = http.Response("Error", 100);
  Future<http.Response> getProducts(context) async {
    try {
      var uri =
          Uri.parse('https://flutter-task-hala-tech.herokuapp.com/products');
      print('begin  request');
      setState(() {
        isLoading = true;
      });
      var response = await http.get(uri);
      print('return from request');
      setState(() {
        isLoading = false;
      });
      var body = json.decode(response.body);
      print('$body');
      print("${response.statusCode}");
      statusCode = response.statusCode;
      if (statusCode == 200) {
        print('Successful');
        for (int i = 0; i < body.length; i++) {
          print('${body["products"][2]["market"]["address"]}');
          print('${body["products"][i]["name"]}');
          //Add product into the box
          Hive.box<Product>('products').add(Product()
            ..name = body["products"][i]["name"]
            ..id = int.parse(body["products"][i]["id"])
            ..price = body["products"][i]["price"].toString()
            ..imageUrl = body["products"][i]["imageUrl"]
            ..rate = body["products"][i]["rate"].toString()
            ..description = body["products"][i]["description"]
            ..marketName = body["products"][i]["market"]["name"]
            ..marketAddress = body["products"][i]["market"]["address"]);
          print('${Hive.box<Product>('products').values}');
          print('${Hive.box<Product>('products').keys}');
        }
      }
      return response;
    } catch (e) {
      print('catch $e');
      await showDialogApp(context,
          'Something wrong while loading the products!, please check your connection and try again');
      return response;
    }
  }

  @override
  void initState() {
    tz.initializeTimeZones();
    /*var keys = Hive.box<Product>('products').keys;
    Hive.box<Product>('products').deleteAll(keys);*/
    super.initState();
  }

  @override
  void dispose() {
    //Hive.box('products').close();
    super.dispose();
  }

  Widget content() {
    if (Hive.box<Product>('products').values.isEmpty)
      return Column(
        children: [
          EmptyShoppingCartPage(),
          IconButton(
              onPressed: () async {
                await getProducts(context);
              },
              icon: Icon(Icons.refresh_outlined))
        ],
      );
    else
      return ValueListenableBuilder<Box<Product>>(
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
                //Hive.box<User>('user').getAt(0)!.isEmptyShoppingCart = false;
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
      );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      drawer: DrawerApp(),
      bottomNavigationBar: BottomNavigationBarUsed(0),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              EmptyShoppingCartPage(),
              IconButton(
                  onPressed: () async {
                    await getProducts(context);
                  },
                  icon: Icon(Icons.refresh_outlined))
            ],
          ),
          if (isLoading)
            Opacity(
              opacity: 0.4,
              child: Container(color: Colors.black, child: spinKit),
            ),
        ],
      ),
    ));
  }
}
