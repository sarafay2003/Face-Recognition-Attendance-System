class DetectionResult {
  final String message;
  final bool success;

  DetectionResult({required this.message, required this.success});

  factory DetectionResult.fromJson(Map<String, dynamic> json) {
    return DetectionResult(
      message: json['message'] ?? '',
      success: json['success'] ?? false,
    );
  }
}
