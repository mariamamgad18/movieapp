class RemoveMovie {
  RemoveMovie({
    required String message,
    required num statusCode,
  })  : _message = message,
        _statusCode = statusCode;

  RemoveMovie.fromJson(dynamic json)
      : _message = json['message'] ?? '',
        _statusCode = json['statusCode'] ?? 0;

  final String _message;
  final num _statusCode;

  RemoveMovie copyWith({String? message, num? statusCode}) => RemoveMovie(
    message: message ?? _message,
    statusCode: statusCode ?? _statusCode,
  );

  String get message => _message;
  num get statusCode => _statusCode;

  Map<String, dynamic> toJson() {
    return {
      'message': _message,
      'statusCode': _statusCode,
    };
  }
}
