import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sport_lottery/features/my_athletes/logic/models/student_model.dart';
import 'package:sport_lottery/helpers/saved_data.dart';

part 'compet_my_students_state.dart';
part 'compet_my_students_cubit.freezed.dart';

class CompetMyStudentsCubit extends Cubit<CompetMyStudentsState> {
  CompetMyStudentsCubit() : super(const CompetMyStudentsState.initial());

  getCompetStudents(String competID) async {
    emit(const CompetMyStudentsState.loading());
    final trenerId = await SavedData.getUid();
    CollectionReference firestoreMyCompet = FirebaseFirestore.instance
        .collection('competitions')
        .doc(competID)
        .collection('users')
        .doc(trenerId)
        .collection('students');

    try {
      final studentList = await firestoreMyCompet.get();
      List<StudentModel> students = [];

      for (var e in studentList.docs) {
        students.add(StudentModel.fromQuerySnapshot(e));
      }

      emit(CompetMyStudentsState.successGet(students));
    } catch (e) {
      emit(CompetMyStudentsState.error(e.toString()));
    }
  }

  addCompetStudent(
      String competID, List<StudentModel> students, String category) async {
    emit(const CompetMyStudentsState.loading());
    final trenerId = await SavedData.getUid();
    CollectionReference firestore = FirebaseFirestore.instance
        .collection('competitions')
        .doc(competID)
        .collection('users')
        .doc(trenerId)
        .collection('students');

    CollectionReference firestoreAthletes = FirebaseFirestore.instance
        .collection('competitions')
        .doc(competID)
        .collection('athletes');

    try {
      for (var e in students) {
        await firestore.doc(e.id).set(e.copyWith(category: category).toJson());
        await firestoreAthletes
            .doc(e.id)
            .set(e.copyWith(category: category).toJson());
      }

      emit(const CompetMyStudentsState.successAdd());
      getCompetStudents(competID);
    } catch (e) {
      emit(CompetMyStudentsState.error(e.toString()));
    }
  }

  deleteCompetStudent(String competID, String studentId) async {
    final trenerId = await SavedData.getUid();
    DocumentReference firestore = FirebaseFirestore.instance
        .collection('competitions')
        .doc(competID)
        .collection('users')
        .doc(trenerId)
        .collection('students')
        .doc(studentId);
    DocumentReference firestoreAthletes = FirebaseFirestore.instance
        .collection('competitions')
        .doc(competID)
        .collection('athletes')
        .doc(studentId);
    try {
      await firestore.delete();
      await firestoreAthletes.delete();
      getCompetStudents(competID);
    } catch (e) {
      emit(CompetMyStudentsState.error(e.toString()));
    }
  }
}
