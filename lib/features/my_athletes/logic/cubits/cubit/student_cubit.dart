import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sport_lottery/features/my_athletes/logic/models/student_model.dart';
import 'package:sport_lottery/helpers/saved_data.dart';

part 'student_state.dart';
part 'student_cubit.freezed.dart';

class StudentCubit extends Cubit<StudentState> {
  StudentCubit() : super(const StudentState.initial());

  getStudents() async {
    emit(const StudentState.loading());

    final uId = await SavedData.getUid();

    CollectionReference firestore = FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('students');

    try {
      final studentList = await firestore.get();
      List<StudentModel> students = [];

      for (var e in studentList.docs) {
        students.add(StudentModel.fromQuerySnapshot(e));
      }

      emit(StudentState.successGet(students));
    } catch (e) {
      emit(StudentState.error(e.toString()));
    }
  }

  getCategoryStudents(String category) async {
    emit(const StudentState.loading());

    final uId = await SavedData.getUid();

    CollectionReference firestore = FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('students');

    try {
      final studentList = await firestore.get();
      List<StudentModel> students = [];

      for (var e in studentList.docs) {
        students.add(StudentModel.fromQuerySnapshot(e));
      }

      if (category == 'Дети') {
        students.removeWhere(
          (e) => e.age != 2014 && e.age != 2015,
        );
      } else if (category == 'Юноши') {
        students.removeWhere(
          (e) => e.age != 2012 && e.age != 2013,
        );
      } else if (category == 'Кадеты') {
        students.removeWhere(
          (e) => e.age != 2011 && e.age != 2010 && e.age != 2009,
        );
      } else if (category == 'Юниоры') {
        students.removeWhere(
          (e) => e.age != 2006 && e.age != 2007 && e.age != 2008,
        );
      }

      emit(StudentState.successGet(students));
    } catch (e) {
      emit(StudentState.error(e.toString()));
    }
  }

  addStudents(StudentModel model) async {
    emit(const StudentState.loading());

    final uId = await SavedData.getUid();

    DocumentReference firestore = FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('students')
        .doc(model.id);

    try {
      await firestore.set(model.toJson());

      emit(const StudentState.successAdd());
    } catch (e) {
      emit(StudentState.error(e.toString()));
    }
  }

  editStudents(StudentModel model) async {
    emit(const StudentState.loading());

    final uId = await SavedData.getUid();

    DocumentReference firestore = FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('students')
        .doc(model.id);

    try {
      await firestore.update(model.toJson());

      emit(const StudentState.successAdd());
    } catch (e) {
      emit(StudentState.error(e.toString()));
    }
  }

  deleteStudent(String id) async {
    final uId = await SavedData.getUid();
    DocumentReference firestore = FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('students')
        .doc(id);
    try {
      await firestore.delete();
      getStudents();
    } catch (e) {
      emit(StudentState.error(e.toString()));
    }
  }
}
