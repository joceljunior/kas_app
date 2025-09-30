abstract class UserState {}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class UserSuccessState extends UserState {
  final String message;
  UserSuccessState({required this.message});
}

class UserErrorState extends UserState {
  final String message;
  UserErrorState({required this.message});
}

class UserListSuccessState extends UserState {
  final List<dynamic> users;
  UserListSuccessState({required this.users});
}
