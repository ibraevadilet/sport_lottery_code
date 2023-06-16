import 'package:cloud_firestore/cloud_firestore.dart';

class StudentModel {
  final String id;
  final String name;
  final int weight;
  final int age;
  final String trainer;
  final String gender;
  final String? category;

  StudentModel({
    required this.id,
    required this.name,
    required this.weight,
    required this.age,
    required this.trainer,
    required this.gender,
    this.category,
  });

  factory StudentModel.fromJson(Map<dynamic, dynamic> json) => StudentModel(
        id: json["id"],
        name: json["name"],
        weight: json["weight"],
        age: json["bith_date"],
        trainer: json["trainer"],
        gender: json["gender"],
        category: json["category"],
      );
  factory StudentModel.fromQuerySnapshot(QueryDocumentSnapshot json) =>
      StudentModel(
        id: json["id"],
        name: json["name"],
        weight: json["weight"],
        age: json["bith_date"],
        trainer: json["trainer"],
        gender: json["gender"],
        category: json.data().toString().contains('category')
            ? json['category']
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "weight": weight,
        "bith_date": age,
        "trainer": trainer,
        "gender": gender,
        "category": category,
      };

  @override
  bool operator ==(covariant StudentModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.weight == weight &&
        other.age == age &&
        other.trainer == trainer &&
        other.gender == gender;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        weight.hashCode ^
        age.hashCode ^
        trainer.hashCode ^
        gender.hashCode;
  }

  StudentModel copyWith({
    String? id,
    String? name,
    int? weight,
    int? age,
    String? trainer,
    String? gender,
    String? category,
  }) {
    return StudentModel(
      id: id ?? this.id,
      name: name ?? this.name,
      weight: weight ?? this.weight,
      age: age ?? this.age,
      trainer: trainer ?? this.trainer,
      gender: gender ?? this.gender,
      category: category ?? this.category,
    );
  }
}
