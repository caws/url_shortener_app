import 'dart:async';
import 'dart:math';

import 'package:shortener_app/common/models/dashboard.dart';
import 'package:shortener_app/common/models/url.dart';
import 'package:shortener_app/common/routes/sub_routes/url_routes.dart';
import 'package:shortener_app/common/utils/http_tunnel.dart';

/// This class consumes the Url Shortener API
class DashboardService {
  // Instantiate our wrapper class for HTTP requests
  HttpTunnel httpTunnel = HttpTunnel();

  /// Fetches a many urls from the database.
  Future<Dashboard> requestDashboard() async {
    httpTunnel.setAuthorizationToken('aaa');
    final response = await httpTunnel.get(UrlRoutes.index());

    // Create a single Url object
    return Dashboard.fromJson(response.data);
  }
}
