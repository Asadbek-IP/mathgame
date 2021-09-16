class Level {
  final int id;
  final int number;
  final int stars;
  final bool unlocked;
  final bool timedLevel;

  Level({
    required this.id,
    required this.number,
    required this.stars,
    required this.unlocked,
    required this.timedLevel,
  });

  Map<String, dynamic> toMap(int world) {
    return {
      "id": id,
      "number": num,
      "stars": stars,
      "unlocked": unlocked ? 1 : 0,
      "timed_level": timedLevel,
      "world": world,
    };
  }

  Level.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        number = map["number"],
        stars = map["stars"],
        unlocked = map["unlocked"],
        timedLevel = map["timed_level"];
}
