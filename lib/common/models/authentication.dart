import 'package:shortener_app/common/models/user.dart';

class Authentication {
  final User user;
  final String token;

  Authentication({this.user, this.token});

  Authentication.fromJson(Map<String, dynamic> json)
      : user = User.fromJson(json["user"]),
        token = json["token"];
}
