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
    return _buildRandomUrl();
  }

  /// Fetches a many urls from the database.
  Future<List<Url>> requestAll() async {
// Simulate network delay.
    final response = await httpTunnel.get(UrlRoutes.index());

    // Create a single Url object
    return null;
  }

  // Used for demonstration purposes, won't be in the final versino
  Url _buildRandomUrl() {
    final random = Random();

    final id = random.nextInt(0xffff);
    final shortUrl = 'https://${random.nextInt(50)}.com';
    final fullUrl = 'https://${random.nextInt(50)}.com';
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
