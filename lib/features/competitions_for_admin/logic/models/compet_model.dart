import 'package:cloud_firestore/cloud_firestore.dart';

class CompetModel {
  final String id;
  final String name;
  final String date;
  final String dedline;

  CompetModel({
    required this.id,
    required this.name,
    required this.date,
    required this.dedline,
  });

  factory CompetModel.fromJson(Map<dynamic, dynamic> json) => CompetModel(
        id: json["id"],
        name: json["name"],
        date: json["date"],
        dedline: json["dedline"],
      );
  factory CompetModel.fromQuerySnapshot(QueryDocumentSnapshot json) =>
      CompetModel(
        id: json["id"],
        name: json["name"],
        date: json["date"],
        dedline: json["dedline"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "date": date,
        "dedline": dedline,
      };
}
