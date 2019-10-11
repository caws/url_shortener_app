import '../routes.dart';

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