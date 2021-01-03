import 'package:flutter/material.dart';
import "package:charcode/charcode.dart";
import 'package:flutter/widgets.dart';
import 'package:my_app/01-components/Hand.dart';
import 'package:my_app/colors.dart';
import 'package:my_app/helpers.dart';
import 'package:my_app/types/card.dart' as CT;

class ColorCharCodes {
  int code;
  Color color;

  ColorCharCodes(this.code, this.color);
}

class CompactCard extends StatefulWidget {
  final CT.Card card;
  double handHeight;
  CT.CardTypes type;
  CompactCard({this.card, this.handHeight, this.type});
  @override
  _CardElemState createState() => _CardElemState();
}

class _CardElemState extends State<CompactCard> {
  double padding = 3;
  double width = 20;
  double height = 20;
  double fontSize = 10;
  List<double> margins = [0, 0, 0, 0];
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
    String suitName = widget.card.suit.name;
    return Container(
      margin:
          EdgeInsets.fromLTRB(margins[0], margins[1], margins[2], margins[3]),
      alignment: Alignment.topCenter,
      width: this.width,
      decoration: BoxDecoration(
          color: MyColors.lightBackground,
          border: Border.all(color: MyColors.lightRed),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(this.padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              String.fromCharCode(colorCharCodeMap[suitName].code),
              style: TextStyle(
                  color: colorCharCodeMap[suitName].color,
                  fontSize: widget.card.id.contains('Joker')
                      ? fontSize
                      : fontSize - 3),
            ),
            Text(
              widget.card.rank.shortName,
              style: TextStyle(color: MyColors.dark, fontSize: fontSize),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
