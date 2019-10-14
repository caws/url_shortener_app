import 'dart:async';
import 'dart:math';

import 'package:shortener_app/common/models/url.dart';
import 'package:shortener_app/common/routes/sub_routes/url_routes.dart';
import 'package:shortener_app/common/services/session.dart';
import 'package:shortener_app/common/utils/http_tunnel.dart';

/// This class consumes the Url Shortener API
class UrlService {
  // Instantiate our wrapper class for HTTP requests
  HttpTunnel _httpTunnel;

  UrlService(this._httpTunnel);

  /// Fetches a single url a database. The [urlId]
  /// parameter is used to build the request.
  Future<Url> requestById(int id) async {
    final response = await _httpTunnel.get(UrlRoutes.show(id));

    // Create a single Url object
    return Url.fromJson(response.data);
  }

  /// Fetches a many urls from the database.
  Future<List<Url>> requestAll() async {
    final response = await _httpTunnel.get(UrlRoutes.index());

    // Create a single Url object
    return Url.fromJsonArray(response.data);
  }

  Future<Url> save(Url url) async {
    final response = await _httpTunnel.post(UrlRoutes.index(), url.toJson());

    // Create a single Url object
    return Url.fromJson(response.data);
  }

  void delete(Url deadUrl) async {
    await _httpTunnel.delete(UrlRoutes.destroy(deadUrl.id), null);
  }
}
