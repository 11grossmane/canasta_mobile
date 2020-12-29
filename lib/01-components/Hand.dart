import 'package:flutter/material.dart';
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
  void changeAce() {
    GameModel.setState((s) => {
          s.setAceSpades(new cardTypes.Card(
              id: 'asdkasd',
              rank: cardTypes.Rank(shortName: 'sdfs', longName: 'sdfs'),
              suit: cardTypes.Suit(name: 'sdfsdf')))
        });
  }

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
    print('start ${startIndex} end ${endIndex}');
    GameModel.setState((s) {
      s.swapCardIDs(
          groupName: 'hand', startIndex: startIndex, endIndex: endIndex);
    });
    return true;
    // GameModel.setState((s) => {s.swapCardIDs('hand', oldIndex, newIndex)});
  }

  @override
  Widget build(BuildContext context) {
    if (GameModel.state.cardPositions == null) return Text('loading');
    var screenWidth = MediaQuery.of(context).size.width * 10;

    return GameModel.rebuilder(() {
      var hand = GameModel.state.cardPositions.groups['hand'];
      var cards = GameModel.state.cardPositions.cards;
      return DragTarget<int>(
          onAcceptWithDetails: this.reorder,
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
                            children: hand.cardIDs
                                .asMap()
                                .entries
                                .map((entry) => Draggable<int>(
                                      key: ValueKey(entry.value),
                                      data: entry.key,
                                      feedback: CardElem(
                                          key: ValueKey(entry.value),
                                          card: cards[entry.value]),
                                      childWhenDragging: Container(
                                        width: 50,
                                      ),
                                      child: CardElem(
                                          key: ValueKey(entry.value),
                                          card: cards[entry.value]),
                                    ))
                                .toList())),
                  )));
    });
  }
}

// Widget sda(){
//   return DragTarget<int>(builder:  (BuildContext context, List<int> incoming, List rejected) =>Container(
//           padding: EdgeInsets.all(0),
//           decoration: BoxDecoration(
//               border: Border.all(color: Colors.green),
//               color: MyColors.darkBackground),
//           child: Container(
//               alignment: Alignment.center,
//               child:  Container(
//                       color: MyColors.darkBlue,
//                       child: ListView(
//                           key: handKey,
//                           //onReorder: onReorder,
//                           scrollDirection: Axis.horizontal,
//                           shrinkWrap: true,
//                           children: hand.cardIDs
//                               .asMap()
//                               .entries
//                               .map((entry) => Draggable<int>(
//                                     key: ValueKey(entry.value),
//                                     data: entry.key,
//                                     feedback: CardElem(
//                                         key: ValueKey(entry.value),
//                                         card: cards[entry.value]),
//                                     childWhenDragging: Container(
//                                       width: 50,
//                                     ),
//                                     child: CardElem(
//                                         key: ValueKey(entry.value),
//                                         card: cards[entry.value]),
//                                   ))
//                               .toList()));
//                 ,
//               )));
// }
