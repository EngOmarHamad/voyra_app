class WorkoutModel {
  final String id;
  final String name;
  final String level;

  WorkoutModel({required this.id, required this.name, required this.level});

  Map<String, dynamic> toMap() => {'name': name, 'level': level};

  factory WorkoutModel.fromDoc(String id, Map<String, dynamic> data) {
    return WorkoutModel(
      id: id,
      name: data['name'] ?? '',
      level: data['level'] ?? '',
    );
  }
}
