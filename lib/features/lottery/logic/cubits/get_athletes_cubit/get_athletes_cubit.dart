import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sport_lottery/features/lottery/logic/models/athlete_model.dart';
import 'package:sport_lottery/features/my_athletes/logic/models/student_model.dart';

part 'get_athletes_state.dart';
part 'get_athletes_cubit.freezed.dart';

class GetAthletesCubit extends Cubit<GetAthletesState> {
  GetAthletesCubit() : super(const GetAthletesState.loading());

  getGirlAthletes(String competID, String category) async {
    emit(const GetAthletesState.loading());
    CollectionReference firestoreAthletes = FirebaseFirestore.instance
        .collection('competitions')
        .doc(competID)
        .collection('athletes');

    List<StudentModel> childMinus24 = [];
    List<StudentModel> childMinus28 = [];

    List<StudentModel> unoshaMinus30 = [];
    List<StudentModel> unoshaMinus35 = [];

    List<StudentModel> kadetMinus41 = [];
    List<StudentModel> kadetMinus44 = [];
    List<StudentModel> kadetMinus47 = [];

    List<StudentModel> juniorMinus46 = [];
    List<StudentModel> juniorMinus49 = [];
    List<StudentModel> juniorMinus52 = [];
    List<StudentModel> juniorMinus55 = [];

    List<AthleteModel> childAthletes() => [
          AthleteModel(
            students: performLottery(childMinus24),
            weightCategory: '- 24',
          ),
          AthleteModel(
            students: performLottery(childMinus28),
            weightCategory: '- 28',
          ),
        ];
    List<AthleteModel> unoshaAthletes() => [
          AthleteModel(
            students: performLottery(unoshaMinus30),
            weightCategory: '- 30',
          ),
          AthleteModel(
            students: performLottery(unoshaMinus35),
            weightCategory: '- 35',
          ),
        ];
    List<AthleteModel> kadetAthletes() => [
          AthleteModel(
            students: performLottery(kadetMinus41),
            weightCategory: '- 41',
          ),
          AthleteModel(
            students: performLottery(kadetMinus44),
            weightCategory: '- 44',
          ),
          AthleteModel(
            students: performLottery(kadetMinus47),
            weightCategory: '- 47',
          ),
        ];
    List<AthleteModel> juniorAthletes() => [
          AthleteModel(
            students: performLottery(juniorMinus46),
            weightCategory: '- 45',
          ),
          AthleteModel(
            students: performLottery(juniorMinus49),
            weightCategory: '- 48',
          ),
          AthleteModel(
            students: performLottery(juniorMinus52),
            weightCategory: '- 51',
          ),
          AthleteModel(
            students: performLottery(juniorMinus55),
            weightCategory: '- 55',
          ),
        ];

    try {
      final students = await firestoreAthletes.get();

      List<QueryDocumentSnapshot> studentList = students.docs;
      studentList.removeWhere((e) => e['category'] != category);
      studentList.removeWhere((e) => e['gender'] != 'Ж');
      for (var e in studentList) {
        final studentModel = StudentModel.fromQuerySnapshot(e);
        if (category == 'Дети') {
          if (studentModel.weight <= 24) {
            childMinus24.add(studentModel);
          } else if (studentModel.weight <= 28) {
            childMinus28.add(studentModel);
          }
        } else if (category == 'Юноши') {
          if (studentModel.weight <= 30) {
            unoshaMinus30.add(studentModel);
          } else if (studentModel.weight <= 35) {
            unoshaMinus35.add(studentModel);
          }
        } else if (category == 'Кадеты') {
          if (studentModel.weight <= 41) {
            kadetMinus41.add(studentModel);
          } else if (studentModel.weight <= 44) {
            kadetMinus44.add(studentModel);
          } else if (studentModel.weight <= 47) {
            kadetMinus47.add(studentModel);
          }
        } else if (category == 'Юниоры') {
          if (studentModel.weight <= 46) {
            juniorMinus46.add(studentModel);
          } else if (studentModel.weight <= 49) {
            juniorMinus49.add(studentModel);
          } else if (studentModel.weight <= 52) {
            juniorMinus52.add(studentModel);
          } else if (studentModel.weight <= 55) {
            juniorMinus55.add(studentModel);
          }
        }
      }

      List<AthleteModel> athletes() {
        switch (category) {
          case 'Дети':
            return childAthletes();
          case 'Юноши':
            return unoshaAthletes();
          case 'Кадеты':
            return kadetAthletes();
          default:
            return juniorAthletes();
        }
      }

      emit(GetAthletesState.success(athletes()));
    } catch (e) {
      emit(GetAthletesState.error(e.toString()));
    }
  }

  getBoyAthletes(String competID, String category) async {
    emit(const GetAthletesState.loading());
    CollectionReference firestoreAthletes = FirebaseFirestore.instance
        .collection('competitions')
        .doc(competID)
        .collection('athletes');

    List<StudentModel> childMinus20 = [];
    List<StudentModel> childMinus24 = [];
    List<StudentModel> childMinus26 = [];
    List<StudentModel> childPlus26_32 = [];

    List<StudentModel> unoshaMinus28 = [];
    List<StudentModel> unoshaMinus30 = [];
    List<StudentModel> unoshaMinus32 = [];
    List<StudentModel> unoshaPlus32_38 = [];

    List<StudentModel> kadetMinus33 = [];
    List<StudentModel> kadetMinus37 = [];
    List<StudentModel> kadetMinus41 = [];
    List<StudentModel> kadetMinus45 = [];
    List<StudentModel> kadetMinus49 = [];
    List<StudentModel> kadetMinus53 = [];
    List<StudentModel> kadetPlus53_59 = [];

    List<StudentModel> juniorMinus45 = [];
    List<StudentModel> juniorMinus48 = [];
    List<StudentModel> juniorMinus51 = [];
    List<StudentModel> juniorMinus55 = [];
    List<StudentModel> juniorMinus59 = [];
    List<StudentModel> juniorMinus63 = [];
    List<StudentModel> juniorMinus68 = [];
    List<StudentModel> juniorMinus73 = [];
    List<StudentModel> juniorPlus73_79 = [];

    List<AthleteModel> childAthletes() => [
          AthleteModel(
            students: performLottery(childMinus20),
            weightCategory: '- 20',
          ),
          AthleteModel(
            students: performLottery(childMinus24),
            weightCategory: '- 24',
          ),
          AthleteModel(
            students: performLottery(childMinus26),
            weightCategory: '- 26',
          ),
          AthleteModel(
            students: performLottery(childPlus26_32),
            weightCategory: '+ 26, не более 32',
          ),
        ];
    List<AthleteModel> unoshaAthletes() => [
          AthleteModel(
            students: performLottery(unoshaMinus28),
            weightCategory: '- 28',
          ),
          AthleteModel(
            students: performLottery(unoshaMinus30),
            weightCategory: '- 30',
          ),
          AthleteModel(
            students: performLottery(unoshaMinus32),
            weightCategory: '- 32',
          ),
          AthleteModel(
            students: performLottery(unoshaPlus32_38),
            weightCategory: '+ 32, не более 38',
          ),
        ];
    List<AthleteModel> kadetAthletes() => [
          AthleteModel(
            students: performLottery(kadetMinus33),
            weightCategory: '- 33',
          ),
          AthleteModel(
            students: performLottery(kadetMinus37),
            weightCategory: '- 37',
          ),
          AthleteModel(
            students: performLottery(kadetMinus41),
            weightCategory: '- 41',
          ),
          AthleteModel(
            students: performLottery(kadetMinus45),
            weightCategory: '- 45',
          ),
          AthleteModel(
            students: performLottery(kadetMinus49),
            weightCategory: '- 49',
          ),
          AthleteModel(
            students: performLottery(kadetMinus53),
            weightCategory: '- 53',
          ),
          AthleteModel(
            students: performLottery(kadetPlus53_59),
            weightCategory: '+ 53, не более 59',
          ),
        ];
    List<AthleteModel> juniorAthletes() => [
          AthleteModel(
            students: performLottery(juniorMinus45),
            weightCategory: '- 45',
          ),
          AthleteModel(
            students: performLottery(juniorMinus48),
            weightCategory: '- 48',
          ),
          AthleteModel(
            students: performLottery(juniorMinus51),
            weightCategory: '- 51',
          ),
          AthleteModel(
            students: performLottery(juniorMinus55),
            weightCategory: '- 55',
          ),
          AthleteModel(
            students: performLottery(juniorMinus59),
            weightCategory: '- 59',
          ),
          AthleteModel(
            students: performLottery(juniorMinus63),
            weightCategory: '- 63',
          ),
          AthleteModel(
            students: performLottery(juniorMinus68),
            weightCategory: '- 68',
          ),
          AthleteModel(
            students: performLottery(juniorMinus73),
            weightCategory: '- 73',
          ),
          AthleteModel(
            students: performLottery(juniorPlus73_79),
            weightCategory: '+ 73, не более 79',
          ),
        ];

    try {
      final students = await firestoreAthletes.get();
      List<QueryDocumentSnapshot> studentList = students.docs;
      studentList.removeWhere((e) => e['category'] != category);
      studentList.removeWhere((e) => e['gender'] != 'М');
      for (var e in studentList) {
        final studentModel = StudentModel.fromQuerySnapshot(e);
        if (category == 'Дети') {
          if (studentModel.weight <= 20) {
            childMinus20.add(studentModel);
          } else if (studentModel.weight <= 24) {
            childMinus24.add(studentModel);
          } else if (studentModel.weight <= 26) {
            childMinus26.add(studentModel);
          } else if (studentModel.weight >= 26 && studentModel.weight <= 33) {
            childPlus26_32.add(studentModel);
          }
        } else if (category == 'Юноши') {
          if (studentModel.weight <= 28) {
            unoshaMinus28.add(studentModel);
          } else if (studentModel.weight <= 30) {
            unoshaMinus30.add(studentModel);
          } else if (studentModel.weight <= 32) {
            unoshaMinus32.add(studentModel);
          } else if (studentModel.weight > 32 && studentModel.weight <= 39) {
            unoshaPlus32_38.add(studentModel);
          }
        } else if (category == 'Кадеты') {
          if (studentModel.weight <= 33) {
            kadetMinus33.add(studentModel);
          } else if (studentModel.weight <= 37) {
            kadetMinus37.add(studentModel);
          } else if (studentModel.weight <= 41) {
            kadetMinus41.add(studentModel);
          } else if (studentModel.weight <= 45) {
            kadetMinus45.add(studentModel);
          } else if (studentModel.weight <= 49) {
            kadetMinus49.add(studentModel);
          } else if (studentModel.weight <= 53) {
            kadetMinus53.add(studentModel);
          } else if (studentModel.weight > 53 && studentModel.weight <= 60) {
            kadetPlus53_59.add(studentModel);
          }
        } else if (category == 'Юниоры') {
          if (studentModel.weight <= 45) {
            juniorMinus45.add(studentModel);
          } else if (studentModel.weight <= 48) {
            juniorMinus48.add(studentModel);
          } else if (studentModel.weight <= 51) {
            juniorMinus51.add(studentModel);
          } else if (studentModel.weight <= 55) {
            juniorMinus55.add(studentModel);
          } else if (studentModel.weight <= 59) {
            juniorMinus59.add(studentModel);
          } else if (studentModel.weight <= 63) {
            juniorMinus63.add(studentModel);
          } else if (studentModel.weight <= 68) {
            juniorMinus68.add(studentModel);
          } else if (studentModel.weight <= 73) {
            juniorMinus73.add(studentModel);
          } else if (studentModel.weight > 73 && studentModel.weight <= 80) {
            juniorPlus73_79.add(studentModel);
          }
        }
      }

      List<AthleteModel> athletes() {
        switch (category) {
          case 'Дети':
            return childAthletes();
          case 'Юноши':
            return unoshaAthletes();
          case 'Кадеты':
            return kadetAthletes();
          default:
            return juniorAthletes();
        }
      }

      emit(GetAthletesState.success(athletes()));
    } catch (e) {
      emit(GetAthletesState.error(e.toString()));
    }
  }
}

List<StudentModel> performLottery(List<StudentModel> students) {
  List<StudentModel> result = List.from(students);

  for (int i = 0; i < result.length - 1; i += 2) {
    if (result[i].trainer == result[i + 1].trainer) {
      int replacementIndex = findReplacementIndex(result, i);
      if (replacementIndex != -1) {
        StudentModel temp = result[i + 1];
        result[i + 1] = result[replacementIndex];
        result[replacementIndex] = temp;
      }
    }
  }

  return result;
}

int findReplacementIndex(List<StudentModel> students, int currentIndex) {
  for (int i = currentIndex + 2; i < students.length; i++) {
    if (students[currentIndex].trainer != students[i].trainer) {
      return i;
    }
  }
  return -1;
}
