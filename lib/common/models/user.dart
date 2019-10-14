class User {
  final int id;
  final String email;

  User({this.id, this.email});

  User.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        email = json["email"];
}
