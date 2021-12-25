import 'package:flutter/material.dart';
import 'package:flutter_task/component/colorsUsed.dart';
import 'package:flutter_task/models/shopping-cart.dart';
import 'package:flutter_task/models/user.dart';
import 'package:flutter_task/widgets/bottom_navigation_bar.dart';
import 'package:flutter_task/widgets/drawer-app.dart';
import 'package:flutter_task/widgets/emptyShoppingCart.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({Key? key}) : super(key: key);

  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  bool? isEmptySoppingCart = false;
  //Hive.box<User>('user').getAt(0)!.isEmptyShoppingCart;

  Widget content() {
    if (!isEmptySoppingCart!)
      return Scaffold(
        drawer: DrawerApp(),
        body: ValueListenableBuilder<Box<ShoppingCart>>(
            valueListenable:
                Hive.box<ShoppingCart>('ShoppingCart').listenable(),
            builder: (context, box, _) {
              final shoppingCartList = box.values.toList().cast<ShoppingCart>();
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) => Dismissible(
                  key: UniqueKey(),
                  onDismissed: (DismissDirection direction) {
                    if (direction == DismissDirection.endToStart) {
                      Hive.box<ShoppingCart>('ShoppingCart').deleteAt(index);
                      if (shoppingCartList.length == 0)
                        Hive.box<User>('user').getAt(0)!.isEmptyShoppingCart =
                            true;
                    }
                  },
                  child: Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: col7,
                          backgroundImage:
                              AssetImage('${shoppingCartList[index].imageUrl}'),
                        ),
                        title: Text('${shoppingCartList[index].name}'),
                        subtitle:
                            Text('${shoppingCartList[index].description}'),
                        dense: false,
                        minLeadingWidth: 20.0,
                        trailing: Text('\$${shoppingCartList[index].price}  '),
                        onTap: () {},
                        horizontalTitleGap: 20.0,
                      ),
                      Divider(
                        color: col1,
                        thickness: 1.0,
                        endIndent: 20.0,
                        indent: 20.0,
                      ),
                    ],
                  ),
                ),
                itemCount: shoppingCartList.length,
              );
            }),
      );
    else
      return EmptyShoppingCartPage();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: content(),
        bottomNavigationBar: BottomNavigationBarUsed(1),
      ),
    );
  }
}
