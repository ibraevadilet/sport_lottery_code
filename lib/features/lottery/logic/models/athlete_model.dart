import 'package:flutter/foundation.dart';

import 'package:sport_lottery/features/my_athletes/logic/models/student_model.dart';

class AthleteModel {
  final List<StudentModel> students;
  final String weightCategory;
  AthleteModel({
    required this.students,
    required this.weightCategory,
  });

  @override
  bool operator ==(covariant AthleteModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.students, students) &&
        other.weightCategory == weightCategory;
  }

  @override
  int get hashCode => students.hashCode ^ weightCategory.hashCode;
}
