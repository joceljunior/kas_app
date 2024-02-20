abstract class HomeState {}

class HomeStateLoading extends HomeState {}

class HomeStateError extends HomeState {}

class HomeStateSuccess extends HomeState {
  final int totalStudents;
  final int totalcrew;

  HomeStateSuccess({required this.totalStudents, required this.totalcrew});
}
