class MovieIsFavorite {
  MovieIsFavorite({
    String? message,
    bool? data,
  }) {
    _message = message ?? '';
    _data = data ?? false;
  }

  MovieIsFavorite.fromJson(dynamic json) {
    _message = json['message'] ?? '';
    _data = json['data'] ?? false;
  }

  String _message = '';
  bool _data = false;

  MovieIsFavorite copyWith({
    String? message,
    bool? data,
  }) =>
      MovieIsFavorite(
        message: message ?? _message,
        data: data ?? _data,
      );

  String get message => _message;
  bool get data => _data;

  Map<String, dynamic> toJson() {
    return {
      'message': _message,
      'data': _data,
    };
  }
}
