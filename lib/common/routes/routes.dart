class Routes {
  static const rootUrl = "http://192.168.25.128:3000";
  static const baseNamespace = "/api";
  static const baseApiVersion = "/v1";

  static buildRoute(String customRoute) {
    return "$rootUrl$baseNamespace$baseApiVersion$customRoute";
  }
}


