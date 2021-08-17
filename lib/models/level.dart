const listOfLevel = [
  {
    "name": "Paides",
    "requiredScore": 0
  },
  {
    "name": "Paidiskoi",
    "requiredScore": 1500
  },
  {
    "name": "Hebontes",
    "requiredScore": 3000
  },
  {
    "name": "Crypteia",
    "requiredScore": 4500
  },
];

class Level {
  int score;
  int nextLevelRequiredScore;
  String levelName;

  Level(int score) {
    int level = 0;

    this.score = score;
    listOfLevel.forEach((elmt) { 
      if (score >= elmt['requiredScore']) {
        level++;
        this.levelName = elmt['name'];
      }
    });

    this.nextLevelRequiredScore = listOfLevel[(level != 4) ? level : level - 1]['requiredScore'];
  }
}
