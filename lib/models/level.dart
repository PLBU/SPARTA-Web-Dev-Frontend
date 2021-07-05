const listOfLevel = [
  {
    "name": "Paides",
    "requiredScore": 0
  },
  {
    "name": "Paidiskoi",
    "requiredScore": 100
  },
  {
    "name": "Hebontes",
    "requiredScore": 200
  },
  {
    "name": "Crypteia",
    "requiredScore": 300
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

    this.nextLevelRequiredScore = listOfLevel[(level != 5) ? level : level - 1]['requiredScore'];
  }
}
