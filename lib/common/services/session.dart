import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shortener_app/common/models/authentication.dart';
import 'package:shortener_app/common/models/dashboard.dart';
import 'package:shortener_app/common/models/url.dart';
import 'package:shortener_app/common/routes/sub_routes/authentication_routes.dart';
import 'package:shortener_app/common/routes/sub_routes/url_routes.dart';
import 'package:shortener_app/common/utils/http_tunnel.dart';

/// This class consumes the Url Shortener API
class SessionService {
  // Instantiate our wrapper class for key:value
  // storage values
  final localStorage = new FlutterSecureStorage();

  /// Stores the token and the moment it was stored.
  /// We'll use that DateTime whenever we try to figure
  /// out if a user is logged and has a valid token.
  void storeToken(String token) async {
    localStorage.write(
        key: "storageDateTime", value: DateTime.now().toIso8601String());
    localStorage.write(key: "token", value: token);
  }

  Future<String> getToken() {
    // Do something to return the token here
    return localStorage.read(key: "token");
  }

  Future<bool> isLogged() async {
    // Do something to return if user is logged or not
    final token = await getToken();

    if (token.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> isTokenValid() async {
    // Gotta make sure the token is present and valid.
    // If it is not present and/or valid, the user should
    // have to login one more time.

    final token = await getToken();

    if (token.length > 0) {
      final currentDate = DateTime.now();
      final dateAsString = await localStorage.read(key: "storageDateTime");
      final date = DateTime.parse(dateAsString);
      final difference = date.difference(currentDate);

      // If the difference in hours is 23 hours, we'll force
      // the user to login again by invalidating this token.
      if (difference.inHours > 23) {
        return false;
      } else {
        return true;
      }
    }

    // If we get here it means the token isn't even present,
    // rendering it invalid.
    return false;
  }
}
