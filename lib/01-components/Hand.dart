import 'package:flutter/material.dart';
import 'package:js_shims/js_shims.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
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
      print('setting state');
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

  bool reorder(DragTargetDetails<cardTypes.CardDragDetails> data) {
    var handsIDs = GameModel.state.cardPositions.groups['hand'].cardIDs;
    var startIndex = data.data.index;
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
    if (this.localCardIDs.length <= 1) return;
    if (data.offset.distance < 20) return;
    var copyIDs =
        GameModel.state.cardPositions.groups['hand'].cardIDs.sublist(0);
    var startIndex = data.data.index;
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
      copyIDs.removeAt(startIndex);
      copyIDs.insert(endIndex, temp);

      this.localCardIDs = copyIDs;
    });

    ;
  }

  @override
  Widget build(BuildContext context) {
    var handHeight = MediaQuery.of(context).size.height / 7;
    if (GameModel.state.cardPositions == null) return Text('loading');
    return GameModel.listen(onSetState: When.always(() {
      setState(() {
        this.localCardIDs =
            GameModel.state.cardPositions.groups['hand'].cardIDs;
        print('setting state');
        this.throttler = new Throttling(duration: Duration(milliseconds: 40));
      });
    }), rebuild: When.data(() {
      var cards = GameModel.state.cardPositions.cards;
      var hand = GameModel.state.cardPositions.groups['hand'].cardIDs;
      print('hand is ${hand}');
      if (this.localCardIDs.isEmpty) return Text('empty');
      return DragTarget<cardTypes.CardDragDetails>(
          onAcceptWithDetails: this.reorder,
          // onWillAccept: reorderLocal,
          onMove: this.reorderLocal,
          builder: (BuildContext context,
                  List<cardTypes.CardDragDetails> incoming, List rejected) =>
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      color: MyColors.darkBackground),
                  child: Container(
                    alignment: Alignment.center,
                    child: Container(
                        color: MyColors.darkBlue,
                        height: handHeight * .7,
                        child: ListView(
                            key: handKey,
                            //onReorder: onReorder,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            children: this
                                .localCardIDs
                                .asMap()
                                .entries
                                .map((entry) =>
                                    Draggable<cardTypes.CardDragDetails>(
                                      key: ValueKey(entry.value),
                                      data: cardTypes.CardDragDetails(
                                          entry.value, entry.key),
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
    }));
  }
}
