class Student {
  final String name;
  final int age;
  final bool single;
  final List<String> description;
  const Student({
    required this.name,
    required this.age,
    required this.single,
    required this.description,
  });

  void addDescription(List<String> additional) =>
      description.addAll(additional);
  Map<String, dynamic> toJson() =>
      {"name": name, "age": age, "single": single, "description": description};

  static Student fromJson(Map<String, dynamic> json) {
    return Student(
        name: json["name"],
        age: json['age'],
        single: json["single"],
        description: List<String>.from(json["description"]));
  }

  @override
  String toString() {
    super.toString();
    return 'Student({name: $name, age: $age, single: $single, description: $description,})';
  }
}
