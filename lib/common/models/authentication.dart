import 'package:shortener_app/common/models/url.dart';

class Authentication {
//  final User user;
  final String token;

  Authentication({this.token});

  Authentication.fromJson(Map<String, dynamic> json) : token = json["token"];
}
