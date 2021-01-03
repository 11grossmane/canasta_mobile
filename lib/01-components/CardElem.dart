import 'package:flutter/material.dart';
import "package:charcode/charcode.dart";
import 'package:flutter/widgets.dart';
import 'package:my_app/01-components/Hand.dart';
import 'package:my_app/colors.dart';
import 'package:my_app/helpers.dart';
import 'package:my_app/types/card.dart' as cardTypes;

class ColorCharCodes {
  int code;
  Color color;
  ColorCharCodes(this.code, this.color);
}

class CardElem extends StatefulWidget {
  final cardTypes.Card card;
  double handHeight;
  CardElem({this.card, this.handHeight});
  @override
  _CardElemState createState() => _CardElemState();
}

class _CardElemState extends State<CardElem> {
  Map<String, ColorCharCodes> colorCharCodeMap = {
    'spades': ColorCharCodes($spades, MyColors.dark),
    'hearts': ColorCharCodes($hearts, MyColors.lightRed),
    'clubs': ColorCharCodes($clubs, MyColors.dark),
    'diamonds': ColorCharCodes($diams, MyColors.lightRed),
    'none': ColorCharCodes($weierp, MyColors.lightRed)
  };

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    final double fontSize = height * .025;
    String suitName = widget.card.suit.name;
    return Container(
      margin: EdgeInsets.fromLTRB(5, 1, 5, 1),
      width: 50,
      height: widget.handHeight,
      decoration: BoxDecoration(
          color: MyColors.lightBackground,
          border: Border.all(color: MyColors.lightRed),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(3),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.card.rank.shortName,
                    style: TextStyle(color: MyColors.dark, fontSize: fontSize),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    String.fromCharCode(colorCharCodeMap[suitName].code),
                    style: TextStyle(
                        color: colorCharCodeMap[suitName].color,
                        fontSize: fontSize),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(widget.card.rank.shortName,
                      style:
                          TextStyle(color: MyColors.dark, fontSize: fontSize)),
                ],
              )
            ]),
      ),
    );
    ;
  }
}
