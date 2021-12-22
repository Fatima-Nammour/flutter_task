import 'package:flutter/material.dart';
import 'package:flutter_task/component/colorsUsed.dart';
import 'package:flutter_task/widgets/bottom_navigation_bar.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
            padding: EdgeInsets.all(15.0),
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                key: Key('key'),
                onDismissed: (DismissDirection direction) {
                  if (direction == DismissDirection.endToStart)
                    print('deleted');
                },
                background: Container(
                  color: col4,
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: col7,
                        backgroundImage:
                            AssetImage('assets/images/shopping_app.png'),
                      ),
                      title: Text('title'),
                      subtitle: Text('sub title'),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete_outline,
                          color: col2,
                        ),
                        onPressed: () {},
                      ),
                      onTap: () {
                        print('move to page show a detail of this item');
                      },
                      horizontalTitleGap: 20.0,
                    ),
                    Divider(
                      color: col1,
                      thickness: 1.0,
                      endIndent: 5.0,
                      indent: 5.0,
                    )
                  ],
                ),
              );
            },
            itemCount: 10),
        bottomNavigationBar: BottomNavigationBarUsed(1),
      ),
    );
  }
}
