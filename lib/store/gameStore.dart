import 'dart:convert';

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
    return _cardPositions;
  }

  set cardPositions(w) {
    _cardPositions = w;
  }

  void setAceSpades(Card card) {
    _cardPositions.cards['Ace-spades'] = card;
  }

  void setInitialCardPositions() async {
    _cardPositions = CardPositions.fromJson(await parseJson(path));
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
