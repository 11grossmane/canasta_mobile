import 'dart:convert';

import 'package:js_shims/js_shims.dart';
import 'package:my_app/helpers.dart';
import 'package:my_app/types/card.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import 'dart:async';
import 'dart:io';

var path = 'assets/card-data.json';

class GameStore {
  CardPositions _cardPositions;
  bool _cardPositionSet = false;
  GameStore([this._cardPositions]);

  CardPositions get cardPositions {
    return this._cardPositions;
  }

  bool get cardPositionsSet {
    return this._cardPositionSet;
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
    group.cardIDs.removeAt(startIndex);
    //adding
    group.cardIDs.insert(endIndex, temp);
    //splice(group.cardIDs, endIndex, 0, temp);
    // _cardPositions.groups[groupName].cardIDs[startIndex] =
    //     group.cardIDs[endIndex];
    // _cardPositions.groups[groupName].cardIDs[endIndex] = temp;
  }

  void moveCardFromHandToTable(
      {String endGroupName, int startIndex, String cardID}) {
    print('data from move to table $endGroupName $startIndex $cardID');
    var hand = this._cardPositions.groups['hand'];
    print('hand is ${hand.cardIDs}');
    var endGroup = this._cardPositions.groups[endGroupName];
    hand.cardIDs.removeAt(startIndex);
    endGroup.cardIDs.add(cardID);
  }

  Future<void> setInitialCardPositions() async {
    _cardPositions = CardPositions.fromJson(await parseJson(path));
    _cardPositions.groups['hand'] = Group(id: 'hand', title: 'Hand', cardIDs: [
      'King-clubs',
      'Seven-hearts',
      'Five-diamonds',
      'Ace-spades',
      'Joker-none'
    ]);

    _cardPositionSet = true;
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
