import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shortener_app/common/models/authentication.dart';
import 'package:shortener_app/common/models/user.dart';

/// This class consumes the Url Shortener API
class SessionService {
  // Instantiate our wrapper class for key:value
  // storage values
  final localStorage = new FlutterSecureStorage();

  /// Stores the token and the moment it was stored.
  /// We'll use that DateTime whenever we try to figure
  /// out if a user is logged and has a valid token.
  void storeSessionData(Authentication sessionData) async {
    localStorage.write(
        key: "storageDateTime", value: DateTime.now().toIso8601String());
    localStorage.write(key: "token", value: sessionData.token);
    localStorage.write(key: "email", value: sessionData.user.email);
    localStorage.write(key: "name", value: sessionData.user.name);
  }

  void discardSessionData() async {
    localStorage.delete(key: "storageDateTime");
    localStorage.delete(key: "token");
    localStorage.delete(key: "email");
    localStorage.delete(key: "name");
  }

  Future<Authentication> getSessionData() async {
    // Do something to return the token here
    final token = await localStorage.read(key: "token");
    final email = await localStorage.read(key: "email");
    final name = await localStorage.read(key: "name");

    return Authentication(
        token: token,
        user: User(
          email: email,
          name: name,
        ));
  }

  Future<bool> isLogged() async {
    // Do something to return if user is logged or not
    final sessionData = await getSessionData();

    if (sessionData.token.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> isTokenValid() async {
    // Gotta make sure the token is present and valid.
    // If it is not present and/or valid, the user should
    // have to login one more time.

    final sessionData = await getSessionData();

    if ((sessionData.token != null) && (sessionData.token.length > 0)) {
      final currentDate = DateTime.now();
      final dateAsString = await localStorage.read(key: "storageDateTime");
      final date = DateTime.parse(dateAsString);
      final difference = currentDate.difference(date);

      // If the difference in hours is 23 hours, we'll force
      // the user to login again by invalidating this token.
      if (difference.inHours > 12) {
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
