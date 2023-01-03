class Answer {
  String? index;
  String? name;

  Answer({
    required this.index,
    required this.name,
  });

  factory Answer.fromJson(Map<String, dynamic> json) => new Answer(
    index: json["index"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "index": index,
    "name": name,
  };

  @override
  String toString() {
    return "Answer(index: $index, name: $name)";
  }

}