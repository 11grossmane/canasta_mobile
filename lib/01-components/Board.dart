import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/01-components/CardSpotRow.dart';
import 'package:my_app/colors.dart';
import 'package:my_app/constants/spotLabels.dart';

class Board extends StatefulWidget {
  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  @override
  Widget build(BuildContext context) {
    if (spotLabelGroups["red"] == null) return Container();
    return Container(
        color: MyColors.darkBackground,
        child: Row(children: [
          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: spotLabelGroups['red']
                    .map((labelRow) => CardSpotRow(
                          labelRow: labelRow,
                        ))
                    .toList()),
          ),
          Container(
            width: 40,
            child: Column(
              children: [],
            ),
          ),
          Expanded(
            child: Column(
                children: spotLabelGroups['blue']
                    .map((labelRow) => CardSpotRow(
                          labelRow: labelRow,
                        ))
                    .toList()),
          ),
        ]));
  }
}
