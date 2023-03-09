abstract class KasError implements Exception {}

class LoginError extends KasError {
  final String message;
  LoginError({
    required this.message,
  });
}

class CrewError extends KasError {
  final String message;
  CrewError({
    required this.message,
  });
}

class StudentError extends KasError {
  final String message;
  StudentError({
    required this.message,
  });
}

class BoxClosedFailure extends KasError {
  final String message;

  BoxClosedFailure({required this.message});
}
