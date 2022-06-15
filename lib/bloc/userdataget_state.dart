part of 'userdataget_bloc.dart';

@immutable
abstract class UserdatagetState {}

class UserdatagetInitial extends UserdatagetState {}

class LoadingState extends UserdatagetState {}

class LoadedState extends UserdatagetState {
  userdata userdataval;
  LoadedState({required this.userdataval});
}

class FailToload extends UserdatagetState {
  String err;
  FailToload({required this.err});
}
