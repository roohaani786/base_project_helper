part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent {}

class GetToDoRequested extends TodoEvent{

}
