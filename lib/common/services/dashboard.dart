import 'dart:async';

import 'package:shortener_app/common/models/dashboard.dart';
import 'package:shortener_app/common/routes/sub_routes/dashboard_routes.dart';
import 'package:shortener_app/common/utils/http_tunnel.dart';

/// This class consumes the Url Shortener API
class DashboardService {
  // Instantiate our wrapper class for HTTP requests
  HttpTunnel _httpTunnel;

  DashboardService(this._httpTunnel);

  /// Fetches a many urls from the database.
  Future<Dashboard> requestDashboard() async {
    final response = await _httpTunnel.get(DashboardRoutes.myDashboard());

    // Create a single Url object
    return Dashboard.fromJson(response.data);
  }
}
