import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/component/colorsUsed.dart';
import 'package:flutter_task/widgets/textReadMore.dart';

class ProductCardDetailed extends StatefulWidget {
  final String? imageUrl;
  final String? name;
  final String? price;
  final String? description;
  final String? rate;
  final String? marketName;
  final String? marketAddress;

  const ProductCardDetailed(
      {this.name,
      this.price,
      this.description,
      this.imageUrl,
      this.marketName,
      this.rate,
      this.marketAddress});

  @override
  State<ProductCardDetailed> createState() => _ProductCardDetailedState();
}

class _ProductCardDetailedState extends State<ProductCardDetailed> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
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
        child: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.6,
              margin: EdgeInsets.all(10.0),
              child: Image.asset(
                '${widget.imageUrl}',
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Center(
                          child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: col1,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(4.0)),
                    child: Text(
                      '${widget.name}',
                      style: TextStyle(color: col1, fontSize: 20.0),
                    ),
                  ))),
                  Expanded(
                      child: Center(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
                      decoration: BoxDecoration(
                        color: col2,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Text(
                        '\$ ${widget.price}',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                    ),
                  )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        '${widget.marketName}',
                        style: TextStyle(color: Colors.black, fontSize: 18.0),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        '${widget.marketAddress}',
                        style: TextStyle(color: Colors.black, fontSize: 18.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //description
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.28,
                  width: MediaQuery.of(context).size.width * 0.6,
                  padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: col1,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(4.0)),
                  child: TextReadMore(widget.description!)),
            ),
            // RichText(text: InlineSpanVisitor()),
          ],
        ),
      ),
    );
  }
}
