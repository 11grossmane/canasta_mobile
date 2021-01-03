import 'package:flutter/material.dart';
import 'package:my_app/01-components/CardSpot.dart';
import 'package:my_app/colors.dart';
import 'package:my_app/constants/spotLabels.dart';

class CardSpotRow extends StatefulWidget {
  List<SpotLabel> labelRow;
  CardSpotRow({this.labelRow});
  @override
  _CardSpotRowState createState() => _CardSpotRowState();
}

class _CardSpotRowState extends State<CardSpotRow> {
  @override
  Widget build(BuildContext context) {
    if (widget.labelRow == null) return Container();
    return Expanded(
      child: Row(
        children: widget.labelRow
            .map((item) => Expanded(
                    child: CardSpot(
                  groupName: item.groupName,
                  label: item.label,
                )))
            .toList(),
      ),
    );
  }
}
