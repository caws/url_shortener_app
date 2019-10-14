import '../routes.dart';

class DashboardRoutes extends Routes {
  static const dashboardsNameSpace = "/my_dashboard";

  static myDashboard() {
    return Routes.buildRoute(dashboardsNameSpace);
  }
}
