class FetchException implements Exception {
  final String message;
  final bool isValidation;
  final Map<String, String> validation;

  const FetchException(
    this.message, {
    this.isValidation = false,
    this.validation = const {},
  });

  @override
  String toString() => message;
}
