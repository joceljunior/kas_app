abstract class StudentState {}

class StudentCreateLoadingState extends StudentState {}

class StudentCreateSuccessState extends StudentState {}

class StudentCreateErrorState extends StudentState {
  final String message;

  StudentCreateErrorState({required this.message});
}
