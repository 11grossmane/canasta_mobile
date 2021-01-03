import 'package:flutter/material.dart';
import 'package:my_app/colors.dart';
import 'package:my_app/helpers.dart';

class CardSpot extends StatefulWidget {
  Color color;
  String name;
  CardSpot({@required this.color, @required this.name});

  @override
  _CardSpotState createState() => _CardSpotState();
}

class _CardSpotState extends State<CardSpot> {
  bool reorder(dynamic data) {
    print('data on card spot' + data);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(1, 1, 1, 1),
        child: DragTarget<dynamic>(
            onAccept: reorder,
            builder: (context, incoming, rejected) => Container(
                  width: MediaQuery.of(context).size.width * (4 / 6) / 5,
                  height: MediaQuery.of(context).size.height * (4 / 6) / 7,
                  decoration: BoxDecoration(
                      color: MyColors.darkBackground,
                      border: Border.all(color: widget.color, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  alignment: Alignment.center,
                  child: Text(
                    widget.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: MyColors.lightBackground, fontSize: 12),
                  ),
                )));
  }
}
