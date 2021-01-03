import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/01-components/CardSpotRow.dart';
import 'package:my_app/colors.dart';
import 'package:my_app/types/spotLabels.dart';

class Board extends StatefulWidget {
  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  Map<String, List<List<SpotLabel>>> spotLabelGroups = {
    "red": [
      [SpotLabel('Wild', 'redWild'), SpotLabel('Eight', 'redEight')],
      [SpotLabel('Three', 'redThree'), SpotLabel('Nine', 'redNine')],
      [SpotLabel('Four', 'redFour'), SpotLabel('Ten', 'redTen')],
      [SpotLabel('Five', 'redFive'), SpotLabel('Jack', 'redJack')],
      [SpotLabel('Six', 'redSix'), SpotLabel('Queen', 'redQueen')],
      [SpotLabel('Seven', 'redSeven'), SpotLabel('King', 'redKing')],
      [SpotLabel('Ace', 'redAce')]
    ],
    "blue": [
      [SpotLabel('Wild', 'blueWild'), SpotLabel('Eight', 'blueEight')],
      [SpotLabel('Three', 'blueThree'), SpotLabel('Nine', 'blueNine')],
      [SpotLabel('Four', 'blueFour'), SpotLabel('Ten', 'blueTen')],
      [SpotLabel('Five', 'blueFive'), SpotLabel('Jack', 'blueJack')],
      [SpotLabel('Six', 'blueSix'), SpotLabel('Queen', 'blueQueen')],
      [SpotLabel('Seven', 'blueSeven'), SpotLabel('King', 'blueKing')],
      [SpotLabel('Ace', 'blueAce')]
    ],
  };
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
