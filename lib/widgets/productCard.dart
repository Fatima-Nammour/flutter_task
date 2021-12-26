import 'package:flutter/material.dart';
import 'package:flutter_task/component/colorsUsed.dart';
import 'package:flutter_task/widgets/textReadMore.dart';

class ProductCard extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final String? price;
  final String? description;
  final String? rate;
  final String? marketName;
  final String? marketAddress;
  final Function? onPressAdd;
  final Function? onPressDetail;

  const ProductCard(
      {this.name,
      this.price,
      this.description,
      this.imageUrl,
      this.marketName,
      this.rate,
      this.marketAddress,
      this.onPressAdd,
      this.onPressDetail});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            spreadRadius: 1.0,
            color: col2,
            blurRadius: 5,
            offset: Offset(2, 2),
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          20.0,
        ),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(8.0),
            child: Image.network(
              '$imageUrl',
              fit: BoxFit.contain,
              /*height: MediaQuery.of(context).size.height * 0.6,
                    width: MediaQuery.of(context).size.width * 0.6,*/
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Center(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
                    decoration: BoxDecoration(
                        color: col2, borderRadius: BorderRadius.circular(5.0)),
                    child: Text(
                      '\$ $price',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )),
                Expanded(
                    child: Center(
                        child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: col1,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(4.0)),
                  child: Text(
                    '$name',
                    style: TextStyle(color: col1, fontFamily: 'Oswald'),
                  ),
                ))),
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0), child: TextReadMore('$description')),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: IconButton(
                      onPressed: () {
                        onPressDetail!();
                      },
                      icon: Icon(
                        Icons.info_outline,
                        color: col1,
                        size: 30.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Center(
                  child: IconButton(
                    focusColor: Colors.red,
                    onPressed: () {
                      onPressAdd!();
                      print('pressed');
                    },
                    icon: Icon(
                      Icons.add_shopping_cart_outlined,
                      color: col1,
                      size: 30.0,
                    ),
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
