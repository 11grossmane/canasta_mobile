import 'package:flutter/material.dart';
import 'package:my_app/01-components/CardSpot.dart';
import 'package:my_app/colors.dart';
import 'package:my_app/types/spotLabels.dart';

class CardSpotRow extends StatefulWidget {
  List<SpotLabel> labelRow;
  CardSpotRow({this.labelRow});
  @override
  _CardSpotRowState createState() => _CardSpotRowState();
}

class _CardSpotRowState extends State<CardSpotRow> {
  Color determineSpotColor(String colorLabel) {
    print('collorLabel ${colorLabel}');
    return colorLabel.contains('red') ? MyColors.lightRed : MyColors.lightBlue;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.labelRow == null) return Container();
    return Expanded(
      child: Row(
        children: widget.labelRow
            .map((item) => Expanded(
                    child: CardSpot(
                  color: determineSpotColor(item.colorLabel),
                  name: item.label,
                )))
            .toList(),
      ),
    );
  }
}
