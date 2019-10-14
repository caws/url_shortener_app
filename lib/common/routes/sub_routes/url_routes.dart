import '../routes.dart';

class UrlRoutes extends Routes {
  static const urlsNameSpace = "/urls";

  static index() {
    return Routes.buildRoute(urlsNameSpace);
  }

  static show(int id) {
    return Routes.buildRoute("$urlsNameSpace/$id");
  }

  static destroy(int id) {
    return Routes.buildRoute("$urlsNameSpace/$id");
  }
}