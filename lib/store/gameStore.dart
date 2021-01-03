import 'dart:convert';

import 'package:js_shims/js_shims.dart';
import 'package:my_app/helpers.dart';
import 'package:my_app/types/card.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import 'dart:async';
import 'dart:io';

var path = 'assets/card-data.json';

class GameStore {
  CardPositions _cardPositions = CardPositions(cards: {});
  GameStore([this._cardPositions]);

  CardPositions get cardPositions {
    return this._cardPositions;
  }

  set cardPositions(w) {
    this._cardPositions = w;
  }

  void setAceSpades(Card card) {
    this._cardPositions.cards['Ace-spades'] = card;
  }

  void swapCardIDs({String groupName, int startIndex, int endIndex}) {
    var group = this._cardPositions.groups[groupName];
    var temp = group.cardIDs[startIndex];
    //removing
    splice(group.cardIDs, startIndex, 1);
    //adding
    splice(group.cardIDs, endIndex, 0, temp);
    // _cardPositions.groups[groupName].cardIDs[startIndex] =
    //     group.cardIDs[endIndex];
    // _cardPositions.groups[groupName].cardIDs[endIndex] = temp;
  }

  void setInitialCardPositions() async {
    _cardPositions = CardPositions.fromJson(await parseJson(path));
    _cardPositions.groups['hand'].cardIDs = [
      cardPositions.cards.keys.toList()[1],
      cardPositions.cards.keys.toList()[20],
      cardPositions.cards.keys.toList()[40],
      cardPositions.cards.keys.toList()[42],
      cardPositions.cards.keys.toList()[56]
    ];
  }
}

final GameModel = RM.inject<GameStore>(
  () {
    return GameStore();
  },
  //After initialized, it preserves the state it refers to until it is disposed
  onInitialized: (GameStore state) async {
    //state.setInitialCardPositions();
  },
  //Default callbacks for side effects.
  onWaiting: () => print('Is waiting'),
  onData: (GameStore data) => print('Has data:' + data.toString()),
  onError: (error, stack) => print('Has error' + error.toString()),
  //It is disposed when no longer needed
  onDisposed: (GameStore state) => print('Disposed'),
);
