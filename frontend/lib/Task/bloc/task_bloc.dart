import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/Task/bloc/task_event.dart';
import 'package:frontend/Task/bloc/task_state.dart';
import 'package:frontend/Task/data_provider/api_data_provider.dart';
import 'package:frontend/Task/Model/task_model.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    ApiDataProvider apiDataProvider = ApiDataProvider();

    on<TaskTrainerLoadingEvent>((event, emit) async {
      emit(TaskLoading());
      try {
        // get the task for the day from the API.
        final tasks = await apiDataProvider.getTaskByDateAndTraineeId(event.userId, event.date);
        

      } catch (error) {
        emit(TaskLoadingError(error: error.toString()));
      }
    });

    on<TaskAddEvent>((event, emit) async {
      emit(TaskLoading());

      try {
        await apiDataProvider.addTask(event.task, event.userId);
        emit(TaskAddSuccess(task: event.task));
        add(TaskTrainerLoadingEvent(userId: event.userId, date: event.task.date));
      } catch (error) {
        // else emit the error state
        emit(TaskAddError(error: error.toString()));
      }
    });

    on<TaskUpdateEvent>((event, emit) async {
      emit(TaskLoading());

      try {
        await apiDataProvider.updateTask(event.task);
      } catch (error) {
        // else emit the error state
        emit(TaskUpdateError(error: error.toString()));
        return;
      }
      emit(TaskLoadedSuccessfully(task: event.task));
    });

    on<TaskDeleteEvent>((event, emit) async {
      emit(TaskLoading());

      try {
        await apiDataProvider.deleteTask(event.task);
      } catch (error) {
        // else emit the error state
        emit(TaskDeleteError(error: error.toString()));
      }
      emit(TaskInitial());
    });
  }
}
