import 'package:my_app/types/card.dart';

class SpotLabel {
  String label;
  String groupName;
  SpotLabel(this.label, this.groupName);
}

Map<String, List<List<SpotLabel>>> spotLabelGroups = {
  "red": [
    [SpotLabel('Wild', 'redWild'), SpotLabel('Eight', 'redEight')],
    [SpotLabel('Three', 'redThree'), SpotLabel('Nine', 'redNine')],
    [SpotLabel('Four', 'redFour'), SpotLabel('Ten', 'redTen')],
    [SpotLabel('Five', 'redFive'), SpotLabel('Jack', 'redJack')],
    [SpotLabel('Six', 'redSix'), SpotLabel('Queen', 'redQueen')],
    [SpotLabel('Seven', 'redSeven'), SpotLabel('King', 'redKing')],
    [SpotLabel('Ace', 'redAce')]
  ],
  "blue": [
    [SpotLabel('Wild', 'blueWild'), SpotLabel('Eight', 'blueEight')],
    [SpotLabel('Three', 'blueThree'), SpotLabel('Nine', 'blueNine')],
    [SpotLabel('Four', 'blueFour'), SpotLabel('Ten', 'blueTen')],
    [SpotLabel('Five', 'blueFive'), SpotLabel('Jack', 'blueJack')],
    [SpotLabel('Six', 'blueSix'), SpotLabel('Queen', 'blueQueen')],
    [SpotLabel('Seven', 'blueSeven'), SpotLabel('King', 'blueKing')],
    [SpotLabel('Ace', 'blueAce')]
  ],
};
