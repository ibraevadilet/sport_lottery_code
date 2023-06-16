import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_lottery/features/my_athletes/logic/cubits/cubit/student_cubit.dart';
import 'package:sport_lottery/features/my_athletes/widgets/show_add_dialog.dart';
import 'package:sport_lottery/features/my_athletes/widgets/student_widget.dart';
import 'package:sport_lottery/widgets/app_error_text.dart';
import 'package:sport_lottery/widgets/app_indicator.dart';
import 'package:sport_lottery/widgets/custom_app_bar.dart';

class MyAthletesScreen extends StatefulWidget {
  const MyAthletesScreen({super.key});

  @override
  State<MyAthletesScreen> createState() => _MyAthletesScreenState();
}

class _MyAthletesScreenState extends State<MyAthletesScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentCubit()..getStudents(),
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Мои ученики'),
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            onPressed: () async {
              await showAddDialog(context, () {
                context.read<StudentCubit>().getStudents();
              });
            },
            child: const Icon(
              Icons.add,
            ),
          ),
        ),
        body: BlocBuilder<StudentCubit, StudentState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () => const AppIndicator(),
              error: (error) => AppErrorText(error: error),
              successGet: (model) => model.isEmpty
                  ? const Center(
                      child: Text('Вы еще не добавили учеников'),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListView.separated(
                        itemCount: model.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) => StudentWidget(
                          model: model[index],
                        ),
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }
}
