abstract class KasError implements Exception {}

class LoginError extends KasError {
  final String message;
  LoginError({
    required this.message,
  });
}
