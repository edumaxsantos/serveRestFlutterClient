class Response {
  final int statusCode;
  final Map<String, dynamic>? body;

  Response({
    required this.statusCode,
    this.body,
  });
}
