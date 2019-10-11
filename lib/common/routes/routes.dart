class Routes {
  static const rootUrl = "http://192.168.25.128:3000";
  static const baseNamespace = "/api";
  static const baseApiVersion = "/v1";

  static buildRoute(String customRoute) {
    return "$rootUrl$baseNamespace$baseApiVersion$customRoute";
  }
}

class UrlRoutes extends Routes {
  static const urlsNameSpace = "/urls";

  static index() {
    return Routes.buildRoute(urlsNameSpace);
  }

  static show(int id) {
    return Routes.buildRoute("$urlsNameSpace/$id");
  }
}

class AuthenticationRoutes extends Routes {
  static const authenticationLogin = "/login";
  static const authenticationSignup = "/signup";

  static login() {
    return Routes.buildRoute(authenticationLogin);
  }

  static signup() {
    return Routes.buildRoute(authenticationSignup);
  }
}
