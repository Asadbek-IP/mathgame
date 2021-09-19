class World {
  final int id;
  final int difficulty;
  final String image;
  final bool unlocked;
  final int stars;
  final List<String> allowedOperations;
  final int max;

  World({
    required this.id,
    required this.difficulty,
    required this.image,
    required this.unlocked,
    required this.stars,
    required this.allowedOperations,
    required this.max,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "stars": stars,
      "difficulty": difficulty,
      "image": image,
      "unlocked": unlocked,
      "allowed_operations": allowedOperations.join("|"),
      "max": max,
    };
  }

  World.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        difficulty = map["difficulty"],
        unlocked = map["unlocked_count"] > 0,
        stars = map["stars"],
        image = map["image"],
        allowedOperations = (map["allowed_operations"] as String).split("|"),
        max = map["max"];

  @override
  String toString() {
    return toMap().toString();
  }
}
