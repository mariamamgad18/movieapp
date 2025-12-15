class AddMovieToFav {
  AddMovieToFav({
    List<String>? message,
    String? error,
    num? statusCode,
  }) {
    _message = message ?? [];
    _error = error ?? '';
    _statusCode = statusCode ?? 0;
  }

  AddMovieToFav.fromJson(dynamic json) {
    _message = json['message'] != null ? json['message'].cast<String>() : [];
    _error = json['error'] ?? '';
    _statusCode = json['statusCode'] ?? 0;
  }

  List<String> _message = [];
  String _error = '';
  num _statusCode = 0;

  AddMovieToFav copyWith({
    List<String>? message,
    String? error,
    num? statusCode,
  }) => AddMovieToFav(
    message: message ?? _message,
    error: error ?? _error,
    statusCode: statusCode ?? _statusCode,
  );

  List<String> get message => _message;
  String get error => _error;
  num get statusCode => _statusCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['error'] = _error;
    map['statusCode'] = _statusCode;
    return map;
  }
}
