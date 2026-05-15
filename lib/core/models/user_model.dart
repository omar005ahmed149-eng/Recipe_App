class UserModel {
  String name;
  String id;
  String email;
  static UserModel? currentUser;
  String phoneNumber;
  String poster;

  UserModel({
    required this.poster,
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
  });

  UserModel.fromjson(Map<String, dynamic> json, String id)
      : this(
          id: id,
          name: json["name"] ?? "",
          email: json["email"] ?? "",
          phoneNumber: json["phoneNumber"] ?? "",
          poster: json["poster"] ?? "",
        );

  Map<String, dynamic> tojson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "phoneNumber": phoneNumber,
      "poster": poster,
    };
  }
}
