import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/Task/bloc/task_event.dart';
import 'package:frontend/Task/bloc/task_state.dart';
import 'package:frontend/Task/data_provider/api_data_provider.dart';
import 'package:frontend/Task/Model/task_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../serviceLocator.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    ApiDataProvider apiDataProvider = ApiDataProvider();
    SharedPreferences preferences = ServiceLocator().preferences;

    on<TaskLoadingEvent>((event, emit) async {
      emit(TaskLoading());
      try {
        await Future.delayed(const Duration(seconds: 3));
        final String accessToken = preferences.getString("access_token")!;
        // We have to send the date clocked from the frontend to the backend.

      } catch (error) {
        emit(TaskLoadingError(error: error.toString()));
      }
      emit(
        TaskLoadedSuccessfully(
          task: Task.fromJson(
            {
              "title": "${event.date.weekday} Do 40 Pushups",
              "description":
                  "=> Do 10 pushups for 4 rounds\n Take 5 minutes rest between each round",
              "date": "2021-07-01",
              "time": "12:00:00",
              "isCompleted": false,
              "id": 1,
              "userId": 1
            },
          ),
        ),
      );
      // emit(TaskIsEmpty());
    });

    on<TaskAddEvent>((event, emit) async {
      emit(TaskLoading());

      try {
        final String accessToken = preferences.getString("access_token")!;
        await apiDataProvider.createTask(
            task: event.task, accessToken: accessToken);
        emit(TaskAddSuccess(task: event.task));
        add(TaskLoadingEvent(userId: event.userId, date: event.task.date));
      } catch (error) {
        // else emit the error state
        emit(TaskAddError(error: error.toString()));
      }
    });

    on<TaskUpdateEvent>((event, emit) async {
      emit(TaskLoading());

      try {
        final String accessToken = preferences.getString("access_token")!;
        await apiDataProvider.updateTask(
            task: event.task, accessToken: accessToken);
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
        final String accessToken = preferences.getString("access_token")!;

        await apiDataProvider.deleteTask(
            taskId: event.task.id, accessToken: accessToken);
      } catch (error) {
        // else emit the error state
        emit(TaskDeleteError(error: error.toString()));
      }
      emit(TaskInitial());
    });

    on<TaskAddDummyEvent>((event, emit) {
      // emit a fake task added event to show a placeholder task
      String year = DateTime.now().year.toString();

      String month = DateTime.now().month.toString().length == 1
          ? "0${DateTime.now().month}"
          : DateTime.now().month.toString();
      String day = DateTime.now().day.toString().length == 1
          ? "0${DateTime.now().day}"
          : DateTime.now().day.toString();

      emit(TaskLoadedSuccessfully(
          task: Task.fromJson({
        "title": "New Task",
        "description": "New Task Description",
        // current date in the format 2021-09-01
        "date": "$year-$month-$day",
        "time":
            "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}",
        "isCompleted": false,
        "id": 0,
        "userId": 0
      })));

      print("Task Loaded emitted");
    });
  }
}
