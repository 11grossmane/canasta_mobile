import 'package:json_annotation/json_annotation.dart';

part 'card.g.dart';

@JsonSerializable()
class CardPositions {
  Map<String, Card> cards = {};

  CardPositions({this.cards});

  factory CardPositions.fromJson(Map<String, dynamic> json) {
    var cards = _$CardPositionsFromJson(json);
    print('cards are ' + cards.toString());
    return cards;
  }

  Map<String, dynamic> toJson() => _$CardPositionsToJson(this);
}

@JsonSerializable()
class Card {
  Rank rank;
  Suit suit;
  String id;
  Card({this.rank, this.suit, this.id});

  factory Card.fromJson(Map<String, dynamic> json) => _$CardFromJson(json);

  Map<String, dynamic> toJson() => _$CardToJson(this);
}

@JsonSerializable()
class Rank {
  String shortName;
  String longName;
  Rank({this.shortName, this.longName});

  factory Rank.fromJson(Map<String, dynamic> json) => _$RankFromJson(json);

  Map<String, dynamic> toJson() => _$RankToJson(this);
}

@JsonSerializable()
class Suit {
  String name;
  Suit({this.name});

  factory Suit.fromJson(Map<String, dynamic> json) => _$SuitFromJson(json);

  Map<String, dynamic> toJson() => _$SuitToJson(this);
}
