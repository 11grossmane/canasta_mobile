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
  GlobalKey handKey;
  CardElem({this.card, this.handKey});
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
    final double fontSize = MediaQuery.of(context).size.height * .025;
    String suitName = widget.card.suit.name;
    return Material(
      color: Colors.red,
      child: Padding(
          padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
          child: SizedBox(
            width: 50,
            height: getRenderBox(widget.handKey).size.height,
            child: DecoratedBox(
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
                              style: TextStyle(
                                  color: MyColors.dark, fontSize: fontSize),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              String.fromCharCode(
                                  colorCharCodeMap[suitName].code),
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
                                style: TextStyle(
                                    color: MyColors.dark, fontSize: fontSize)),
                          ],
                        )
                      ]),
                )),
          )),
    );
  }
}
