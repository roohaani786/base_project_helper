import 'dart:async';
import 'package:dio/dio.dart';
import 'package:dubai_ble/domain/config/logger_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/app_module.dart';
import '../../../data/api/api_manager.dart';
import '../../../data/models/models/todo/todo_model.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {

  TodoModel? todoFuture;

  TodoBloc() : super(TodoInitial()) {
    on<GetToDoRequested>(_getTodo);
  }

  void _getTodo(
      GetToDoRequested event,
      Emitter<TodoState> emit,
      ) async {

      emit(TodoLoading());

      todoFuture = await ApiManager(getIt<Dio>()).getTodo();
      logger.i("RESPONSE");
      logger.i(todoFuture?.title??"N/A");

      emit(TodoLoaded());

  }

}
