import 'package:flutter/material.dart';
import 'package:my_app/cardItem.dart';
import 'package:my_app/grid.dart';
import 'package:my_app/helpers.dart';
import 'package:my_app/home.dart';
import 'package:my_app/store/gameStore.dart';
import 'package:my_app/textInputWidget.dart';
import 'package:my_app/types/card.dart' as cardTypes;
import 'package:states_rebuilder/states_rebuilder.dart';

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

  @override
  Widget build(BuildContext context) {
    if (GameModel.state.cardPositions == null) return Text('loading');
    return Container(
        padding: EdgeInsets.all(0),
        alignment: Alignment.center,
        decoration: BoxDecoration(border: Border.all(color: Colors.green)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, i) {
                  var card = GameModel.state.cardPositions.cards[
                      GameModel.state.cardPositions.cards.keys.toList()[i]];
                  return CardItem(
                    card: card,
                  );
                },
              ),
              // child: Row(
              //     children: GameModel.state.cardPositions.cards.keys
              //         .map((key) => GameModel.rebuilder(() => CardItem(
              //             card: GameModel.state.cardPositions.cards[key])))
              //         .toList()),
            )
          ],
        ));
  }
}
