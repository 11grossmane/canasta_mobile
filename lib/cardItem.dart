import 'package:flutter/material.dart';
import 'package:my_app/grid.dart';
import 'package:my_app/home.dart';
import 'package:my_app/textInputWidget.dart';
import 'package:my_app/types/card.dart' as cardTypes;

class CardItem extends StatefulWidget {
  cardTypes.Card card;
  CardItem({this.card});
  @override
  _CardItemState createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  @override
  Widget build(BuildContext context) {
    return Material(
      textStyle: TextStyle(color: Colors.white),
      child: Padding(
          padding: EdgeInsets.fromLTRB(5, 20, 5, 20),
          child: SizedBox(
            width: 50,
            height: 10,
            child: DecoratedBox(
                child: Center(
                  child: Text(widget.card.id[0]),
                ),
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    border: Border.all(color: Colors.black))),
          )),
    );
  }
}
