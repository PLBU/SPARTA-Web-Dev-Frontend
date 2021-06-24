const listOfLevel = [
  {
    "name": "Hippotoxotes",
    "requiredScore": 0
  },
  {
    "name": "Hipparmostes",
    "requiredScore": 100
  },
  {
    "name": "Lokhagos",
    "requiredScore": 200
  },
  {
    "name": "Tagmatarkhis",
    "requiredScore": 300
  },
  {
    "name": "Taxiarhos",
    "requiredScore": 400
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
      if (score > elmt['requiredScore']) {
        level++;
        this.levelName = elmt['name'];
      }
    });

    this.nextLevelRequiredScore = listOfLevel[(level != 5) ? level : level - 1]['requiredScore'];
  }
}
