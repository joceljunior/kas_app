import 'package:kas_app/app/models/crew.dart';
import 'package:kas_app/app/models/student.dart';

abstract class CrewState {}

class CrewInitialState extends CrewState {}

class CrewLoadingState extends CrewState {}

class CrewSuccessState extends CrewState {}

class CrewErrorState extends CrewState {
  final String message;

  CrewErrorState({required this.message});
}

class CrewListSuccessState extends CrewState {
  final List<Crew> crews;

  CrewListSuccessState({required this.crews});
}

class CrewListStudentSuccessState extends CrewState {
  final List<Student> students;

  CrewListStudentSuccessState({required this.students});
}
