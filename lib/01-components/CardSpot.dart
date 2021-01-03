import 'package:flutter/material.dart';
import 'package:my_app/01-components/CardElem.dart';
import 'package:my_app/01-components/CompactCard.dart';
import 'package:my_app/colors.dart';
import 'package:my_app/helpers.dart';
import 'package:my_app/store/gameStore.dart';
import 'package:my_app/types/card.dart';

class CardSpot extends StatefulWidget {
  final String label;
  final String groupName;
  CardSpot({@required this.label, @required this.groupName});

  @override
  _CardSpotState createState() => _CardSpotState();
}

class _CardSpotState extends State<CardSpot> {
  Color backgroundColor = MyColors.darkBackground;

  Color determineSpotColor(String groupName) {
    print('collorLabel $groupName');
    return groupName.contains('red') ? MyColors.lightRed : MyColors.lightBlue;
  }

  bool reorder(CardDragDetails data, String endGroupName) {
    GameModel.setState((s) {
      s.moveCardFromHandToTable(
          cardID: data.name,
          startIndex: data.index,
          endGroupName: endGroupName);
    });
    setState(() {
      this.backgroundColor = MyColors.darkBackground;
    });
    // print('data on card spot' + data);
    return true;
  }

  bool changeBackGroundColor(CardDragDetails data, {bool leaving = false}) {
    setState(() {
      this.backgroundColor = leaving
          ? MyColors.darkBackground
          : determineSpotColor(widget.groupName);
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    var cardIDs =
        GameModel.state.cardPositions.groups[widget.groupName].cardIDs;
    var cards = GameModel.state.cardPositions.cards;
    return GameModel.rebuilder(() => Padding(
        padding: EdgeInsets.fromLTRB(1, 1, 1, 1),
        child: DragTarget<CardDragDetails>(
            onLeave: (data) => this.changeBackGroundColor(data, leaving: true),
            onWillAccept: this.changeBackGroundColor,
            onAccept: (data) => reorder(data, widget.groupName),
            builder: (context, incoming, rejected) => Container(
                width: MediaQuery.of(context).size.width * (4 / 6) / 5,
                height: MediaQuery.of(context).size.height * (4 / 6) / 7,
                decoration: BoxDecoration(
                    color: this.backgroundColor,
                    border: Border.all(
                        color: determineSpotColor(widget.groupName), width: 1),
                    borderRadius: BorderRadius.circular(10)),
                child: cardIDs.isEmpty
                    ? Text(
                        widget.label,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: MyColors.lightBackground, fontSize: 12),
                      )
                    : Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.center,
                        runAlignment: WrapAlignment.spaceEvenly,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: -5,
                        runSpacing: -5,
                        children: cardIDs
                            .asMap()
                            .entries
                            .map((entry) => Container(
                                    child: CompactCard(
                                  card: cards[entry.value],
                                  type: CardTypes.cardSpot,
                                )))
                            .toList())))));
  }
}
