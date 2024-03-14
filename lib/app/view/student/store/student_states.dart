import 'package:kas_app/app/models/student.dart';

abstract class StudentState {}

class StudentCreateLoadingState extends StudentState {}

class StudentListLoadingState extends StudentState {}

class StudentCreateSuccessState extends StudentState {}

class StudentDeleteSuccessState extends StudentState {}

class StudentListSuccessState extends StudentState {
  final List<Student> students;

  StudentListSuccessState({required this.students});
}

class StudentCreateSelectImageState extends StudentState {}

class StudentCreateErrorState extends StudentState {
  final String message;

  StudentCreateErrorState({required this.message});
}

class StudentListErrorState extends StudentState {
  final String message;

  StudentListErrorState({required this.message});
}
