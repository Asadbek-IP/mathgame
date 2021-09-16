class Difficulty {
  final int id;
  final String title;

  Difficulty({
    required this.id,
    required this.title,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
    };
  }

  Difficulty.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        title = map["title"];
}
