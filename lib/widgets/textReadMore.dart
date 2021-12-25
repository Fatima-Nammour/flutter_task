import 'package:flutter/material.dart';
import 'package:flutter_task/component/colorsUsed.dart';

class TextReadMore extends StatefulWidget {
  final String textOfText;
  TextReadMore(this.textOfText);
  @override
  _TextReadMoreState createState() => _TextReadMoreState();
}

class _TextReadMoreState extends State<TextReadMore> {
  // bool datatype to give toggle effect to button and
  // depending on this bool value will show full text or
  // limit the number of line to be viewed in text.
  bool isReadMore = false;
  bool isVisible = false;
  Widget buildText(String text) {
    // if read more is false then show only 3 lines from text
    // else show full text
    final lines = isReadMore ? null : 4;
    return Text(
      text,
      style: TextStyle(fontSize: 25),
      maxLines: lines,
      // overflow properties is used to show 3 dot in text widget
      // so that user can understand there are few more line to read.
      overflow: isReadMore ? TextOverflow.visible : TextOverflow.ellipsis,
    );
  }

  @override
  void initState() {
    if (widget.textOfText.length >= 55.0) {
      isVisible = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        //text widget to display long text
        buildText("${widget.textOfText}"),
        Visibility(
          visible: isVisible,
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(col2),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15.0),
                  ),
                ),
                elevation: MaterialStateProperty.all(5.0),
                shadowColor: MaterialStateProperty.all<Color>(col1),
              ),
              child: Text(
                isReadMore ? 'Read Less' : 'Read More',
                style: TextStyle(
                    color: col1, fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              onPressed: () {
                setState(() {
                  // toggle the bool variable true or false
                  isReadMore = !isReadMore;
                });
              },
            ),
          ),
        )
      ],
    );
  }
}
/*
Text((isReadMore ? 'Read Less' : 'Read More'))
onPress: () {
setState(() {
// toggle the bool variable true or false
isReadMore = !isReadMore;
});
},*/
