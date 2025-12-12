class UpdateProfile {
  UpdateProfile({this.message});

  UpdateProfile.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  String? message;

  UpdateProfile copyWith({String? message}) {
    return UpdateProfile(message: message ?? this.message);
  }

  Map<String, dynamic> toJson() {
    return {'message': message};
  }
}
