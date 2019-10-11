import 'dart:async';
import 'dart:math';

import 'package:shortener_app/common/models/url.dart';
import 'package:shortener_app/common/routes/sub_routes/url_routes.dart';
import 'package:shortener_app/common/utils/http_tunnel.dart';

/// This class consumes the Url Shortener API
class UrlService {
  // Instantiate our wrapper class for HTTP requests
  HttpTunnel httpTunnel = HttpTunnel();

  /// Fetches a single url a database. The [urlId]
  /// parameter is used to build the request.
  Future<Url> requestById(int id) async {
    // Simulate network delay.
    final response = await httpTunnel.get(UrlRoutes.show(id));

    // Create a single Url object
    return Url.fromJson(response.data);
  }

  /// Fetches a many urls from the database.
  Future<List<Url>> requestAll() async {
// Simulate network delay.
    httpTunnel.setAuthorizationToken('aaa');
    final response = await httpTunnel.get(UrlRoutes.index());

    List<Url> urls = List();
    urls.add(_buildRandomUrl());
    urls.add(_buildRandomUrl());
    urls.add(_buildRandomUrl());
    urls.add(_buildRandomUrl());

    // Create a single Url object
    return urls;
  }

  // Used for demonstration purposes, won't be in the final versino
  Url _buildRandomUrl() {
    final random = Random();

    final id = 1;
    final shortUrl = 'https://${1}.com';
    final fullUrl = 'https://${1}.com';
    final pageTitle = 'Google';
    final hitCounter = 50;
    final status = 'Up';
    final createdAt = '2010-10-10';

    return Url(
        id: id,
        shortUrl: shortUrl,
        fullUrl: fullUrl,
        pageTitle: pageTitle,
        hitCounter: hitCounter,
        status: status,
        createdAt: createdAt);
  }
}
