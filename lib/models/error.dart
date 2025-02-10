class AppError {
  String error;
  String errorDescription;

  AppError({
    required this.error,
    required this.errorDescription,
  });

  factory AppError.fromJson(Map<String, dynamic> json) => AppError(
        error: json["error"],
        errorDescription: json["error_description"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "error_description": errorDescription,
      };
}
