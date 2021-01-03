import 'package:flutter/material.dart';
import 'package:js_shims/js_shims.dart';
import 'package:throttling/throttling.dart';

import 'package:my_app/01-components/CardElem.dart';
import 'package:my_app/colors.dart';
import 'package:my_app/helpers.dart';
import 'package:my_app/store/gameStore.dart';
import 'package:my_app/types/card.dart' as cardTypes;

GlobalKey handKey = GlobalKey();

class Hand extends StatefulWidget {
  @override
  _HandState createState() => _HandState();
}

class _HandState extends State<Hand> {
  List<String> localCardIDs = [];
  Throttling throttler;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      this.localCardIDs = GameModel.state.cardPositions.groups['hand'].cardIDs;

      this.throttler = new Throttling(duration: Duration(milliseconds: 40));
    });
  }

  // void changeAce() {
  //   GameModel.setState((s) => {
  //         s.setAceSpades(new cardTypes.Card(
  //             id: 'asdkasd',
  //             rank: cardTypes.Rank(shortName: 'sdfs', longName: 'sdfs'),
  //             suit: cardTypes.Suit(name: 'sdfsdf')))
  //       });
  // }

  bool reorder(DragTargetDetails<int> data) {
    var handsIDs = GameModel.state.cardPositions.groups['hand'].cardIDs;
    var startIndex = data.data;
    var box = getRenderBox(handKey);
    var width = box.size.width;
    var position = box.localToGlobal(Offset.zero);
    var endIndex = getEndIndex(
        offsetX: data.offset.dx + 25, //make anchor center --> cardWidth/2
        width: width,
        lengthOfList: handsIDs.length,
        containerStart: position.dx);

    if (startIndex != endIndex) {
      GameModel.setState((s) {
        s.swapCardIDs(
            groupName: 'hand', startIndex: startIndex, endIndex: endIndex);
      });
    }

    return true;
    // GameModel.setState((s) => {s.swapCardIDs('hand', oldIndex, newIndex)});
  }

  void reorderLocal(DragTargetDetails<dynamic> data) {
    if (data.offset.distance < 20) return;
    var copyIDs =
        GameModel.state.cardPositions.groups['hand'].cardIDs.sublist(0);
    var startIndex = data.data;
    var box = getRenderBox(handKey);
    var width = box.size.width;
    var position = box.localToGlobal(Offset.zero);
    var endIndex = getEndIndex(
        offsetX: data.offset.dx + 25, //make anchor center --> cardWidth/2
        width: width,
        lengthOfList: copyIDs.length,
        containerStart: position.dx);

    setState(() {
      var temp = copyIDs[startIndex];
      //removing
      var splicedCopy = splice(copyIDs, startIndex, 1);
      //adding
      splicedCopy = splice(copyIDs, endIndex, 0, temp);
      this.localCardIDs = splicedCopy;
    });

    ;
  }

  @override
  Widget build(BuildContext context) {
    var handHeight = MediaQuery.of(context).size.height / 7;
    if (GameModel.state.cardPositions == null) return Text('loading');
    return GameModel.rebuilder(() {
      var hand = GameModel.state.cardPositions.groups['hand'];
      var cards = GameModel.state.cardPositions.cards;
      if (hand.cardIDs.length == 0) return null;
      return DragTarget<int>(
          onAcceptWithDetails: this.reorder,
          // onWillAccept: reorderLocal,
          onMove: this.reorderLocal,
          builder: (BuildContext context, List<int> incoming, List rejected) =>
              Container(
                  padding: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      color: MyColors.darkBackground),
                  child: Container(
                    alignment: Alignment.center,
                    child: Container(
                        color: MyColors.darkBlue,
                        child: ListView(
                            key: handKey,
                            //onReorder: onReorder,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            children: this
                                .localCardIDs
                                .asMap()
                                .entries
                                .map((entry) => Draggable<int>(
                                      key: ValueKey(entry.value),
                                      data: entry.key,
                                      feedback: Material(
                                        type: MaterialType.transparency,
                                        child: CardElem(
                                            handHeight: handHeight,
                                            card: cards[entry.value]),
                                      ),
                                      childWhenDragging: Container(
                                        width: 50,
                                        padding:
                                            EdgeInsets.fromLTRB(5, 1, 5, 1),
                                      ),
                                      child: CardElem(
                                          handHeight: handHeight,
                                          card: cards[entry.value]),
                                    ))
                                .toList())),
                  )));
    });
  }
}
