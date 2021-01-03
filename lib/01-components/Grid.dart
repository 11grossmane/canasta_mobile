import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:my_app/01-components/Board.dart';
import 'package:my_app/01-components/hand.dart';
import 'package:my_app/colors.dart';

const cellRed = Color(0xffc73232);
const cellMustard = Color(0xffd7aa22);
const cellGrey = Color(0xffcfd4e0);
const cellBlue = Color(0xff1553be);
const background = Color(0xff242830);

class Grid extends StatefulWidget {
  @override
  _GridState createState() => _GridState();
}

class _GridState extends State<Grid> {
  Widget _buildItemForColor(Color c) => SizedBox.expand(
        child: DecoratedBox(decoration: BoxDecoration(color: c)),
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(title: Text('Canasta')),
            body: Container(
              color: MyColors.darkBackground,
              child: LayoutGrid(
                columnGap: 12,
                rowGap: 12,
                templateColumnSizes: [
                  FlexibleTrackSize(1),
                  FlexibleTrackSize(1),
                  FlexibleTrackSize(1),
                  FlexibleTrackSize(1),
                  FlexibleTrackSize(1),
                  FlexibleTrackSize(1),
                ],
                templateRowSizes: [
                  FlexibleTrackSize(1),
                  FlexibleTrackSize(1),
                  FlexibleTrackSize(1),
                  FlexibleTrackSize(1),
                  FlexibleTrackSize(1),
                  FlexibleTrackSize(1),
                ],
                children: [
                  // Column 1
                  Board().withGridPlacement(
                      columnStart: 1, rowStart: 1, rowSpan: 4, columnSpan: 4),
                  Hand().withGridPlacement(
                    columnStart: 0,
                    rowStart: 5,
                    columnSpan: 6,
                  ),
                  // // Column 2
                  // _buildItemForColor(cellRed).withGridPlacement(
                  //   columnStart: 1,
                  //   rowStart: 0,
                  //   rowSpan: 4,
                  // ),
                  // // Column 3
                  // _buildItemForColor(cellBlue).withGridPlacement(
                  //   columnStart: 2,
                  //   columnSpan: 3,
                  //   rowStart: 0,
                  // ),
                  // _buildItemForColor(cellMustard).withGridPlacement(
                  //   columnStart: 2,
                  //   columnSpan: 3,
                  //   rowStart: 1,
                  //   rowSpan: 2,
                  // ),
                  // _buildItemForColor(cellGrey).withGridPlacement(
                  //   columnStart: 2,
                  //   rowStart: 3,
                  // ),
                  // // Column 4
                  // _buildItemForColor(cellBlue).withGridPlacement(
                  //   columnStart: 3,
                  //   rowStart: 3,
                  // ),
                  // // Column 5
                  // _buildItemForColor(cellMustard).withGridPlacement(
                  //   columnStart: 4,
                  //rowStart: 3,
                  //),
                ],
              ),
            )));
  }
}
