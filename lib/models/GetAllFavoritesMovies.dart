class GetAllFavoritesMovies {
  GetAllFavoritesMovies({
    String? message,
    List<Data>? data,
  }) {
    _message = message ?? '';
    _data = data ?? [];
  }

  GetAllFavoritesMovies.fromJson(dynamic json) {
    _message = json['message'] ?? '';
    _data = [];

    if (json['data'] != null) {
      json['data'].forEach((v) {
        _data.add(Data.fromJson(v));
      });
    }
  }

  String _message = '';
  List<Data> _data = [];

  String get message => _message;
  List<Data> get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['data'] = _data.map((v) => v.toJson()).toList();
    return map;
  }
}
class Data {
  Data({
    String? movieId,
    String? name,
    num? rating,
    String? imageURL,
    String? year,
  }) {
    _movieId = movieId ?? '';
    _name = name ?? '';
    _rating = rating ?? 0;
    _imageURL = imageURL ?? '';
    _year = year ?? '';
  }

  Data.fromJson(dynamic json) {
    _movieId = json['movieId'] ?? '';
    _name = json['name'] ?? '';
    _rating = json['rating'] ?? 0;
    _imageURL = json['imageURL'] ?? '';
    _year = json['year'] ?? '';
  }

  String _movieId = '';
  String _name = '';
  num _rating = 0;
  String _imageURL = '';
  String _year = '';

  String get movieId => _movieId;
  String get name => _name;
  num get rating => _rating;
  String get imageURL => _imageURL;
  String get year => _year;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['movieId'] = _movieId;
    map['name'] = _name;
    map['rating'] = _rating;
    map['imageURL'] = _imageURL;
    map['year'] = _year;
    return map;
  }
}
