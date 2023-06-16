import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sport_lottery/features/competitions_for_admin/logic/models/compet_model.dart';

part 'competition_state.dart';
part 'competition_cubit.freezed.dart';

class CompetitionCubit extends Cubit<CompetitionState> {
  CompetitionCubit() : super(const CompetitionState.initial());

  getCompets() async {
    emit(const CompetitionState.loading());

    CollectionReference firestore =
        FirebaseFirestore.instance.collection('competitions');

    try {
      final competList = await firestore.get();
      List<CompetModel> compets = [];

      for (var e in competList.docs) {
        compets.add(CompetModel.fromQuerySnapshot(e));
      }

      emit(CompetitionState.successGet(compets));
    } catch (e) {
      emit(CompetitionState.error(e.toString()));
    }
  }

  addCompets(CompetModel model) async {
    emit(const CompetitionState.loading());

    DocumentReference firestore =
        FirebaseFirestore.instance.collection('competitions').doc(model.id);

    try {
      await firestore.set(model.toJson());

      emit(const CompetitionState.successAdd());
    } catch (e) {
      emit(CompetitionState.error(e.toString()));
    }
  }

  deleteCompets(String id) async {
    DocumentReference firestore =
        FirebaseFirestore.instance.collection('competitions').doc(id);
    try {
      await firestore.delete();
      getCompets();
    } catch (e) {
      emit(CompetitionState.error(e.toString()));
    }
  }
}
