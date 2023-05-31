import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/Task/views/trainerTask.dart';
import 'package:frontend/trainee/views/trainee_personal_information.dart';
import 'package:go_router/go_router.dart';
import '../../UI/common/loading.dart';
import '../../trainer/trainer.dart';
import '../../weight/views/weight_chart.dart';
import '../trainee.dart';

// a trainee detail page that takes the trainee id as a constuctor
class TraineeDetailForTrainer extends StatelessWidget {
  final String id;
  const TraineeDetailForTrainer({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TraineeBloc, TraineeState>(
      builder: (context, state) {
        final traineeBloc = context.watch<TraineeBloc>();
        if (state is TrainerInitial){
          traineeBloc.add(TraineeDetailLoadEvent(id: int.parse(id)));
          return const LoadingScreen();
        }
        if (state is TrainerLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TrainerLoadingError) {
          return const Center(
            child: Text('Error'),
          );
        }
        return Scaffold(
          appBar: AppBar(
            // a backbtn to go back to the previous page
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                context.pop();
              },
            ),
            title: const Text('Trainee Details Page'),
            // a  . . . that drops down a menu that says fire trainee
          ),
          body: SingleChildScrollView(
            child: Column(children: [
              TraineePersonalInformation(id: int.parse(id)),
              SizedBox(
                height: 200,
                child: WeightChartHandler(id: int.parse(id)),
              ),
              TrainerTask(id: int.parse(id)),
            ]),
          ),
        );
      },
    );
  }
}
