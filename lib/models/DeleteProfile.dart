class DeleteProfile {
  DeleteProfile({this.message});

  DeleteProfile.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  String? message;

  DeleteProfile copyWith({String? message}) {
    return DeleteProfile(message: message ?? this.message);
  }

  Map<String, dynamic> toJson() {
    return {'message': message};
  }
}
