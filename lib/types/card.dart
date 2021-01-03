import 'package:json_annotation/json_annotation.dart';

part 'card.g.dart';

@JsonSerializable()
class CardPositions {
  Map<String, Card> cards;
  Map<String, Group> groups;

  CardPositions();

  factory CardPositions.fromJson(Map<String, dynamic> json) {
    var cardPositions = _$CardPositionsFromJson(json);
    return cardPositions;
  }

  Map<String, dynamic> toJson() => _$CardPositionsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Group {
  String id;
  String title;
  List<String> cardIDs;
  Group({this.id, this.title, this.cardIDs});

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  Map<String, dynamic> toJson() => _$GroupToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Card {
  Rank rank;
  Suit suit;
  String id;
  Card({this.rank, this.suit, this.id});

  factory Card.fromJson(Map<String, dynamic> json) => _$CardFromJson(json);

  Map<String, dynamic> toJson() => _$CardToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Rank {
  String shortName;
  String longName;
  Rank({this.shortName, this.longName});

  factory Rank.fromJson(Map<String, dynamic> json) => _$RankFromJson(json);

  Map<String, dynamic> toJson() => _$RankToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Suit {
  String name;
  Suit({this.name});

  factory Suit.fromJson(Map<String, dynamic> json) => _$SuitFromJson(json);

  Map<String, dynamic> toJson() => _$SuitToJson(this);
}

class CardDragDetails {
  String name;
  int index;
  CardDragDetails(this.name, this.index);
}

enum CardTypes { cardSpot, hand }
