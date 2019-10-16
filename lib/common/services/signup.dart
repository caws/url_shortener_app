import 'dart:async';
import 'dart:convert';

import 'package:shortener_app/common/models/user.dart';
import 'package:shortener_app/common/routes/sub_routes/authentication_routes.dart';
import 'package:shortener_app/common/utils/http_tunnel.dart';

/// This class consumes the Url Shortener API
class SignupService {
  // Instantiate our wrapper class for HTTP requests
  HttpTunnel _httpTunnel;

  SignupService(this._httpTunnel);

  /// Fetches a many urls from the database.
  Future<User> signup(String email, String password) async {
    var authenticationData = json.encode({'email': email, 'password': password});

    final response = await _httpTunnel.post(AuthenticationRoutes.signup(), authenticationData);

    // Create a single Url object
    return User.fromJson(response.data);
  }
}
