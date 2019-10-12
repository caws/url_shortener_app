import 'package:flutter/widgets.dart';
import 'package:shortener_app/common/services/dashboard.dart';

import 'dashboard_bloc.dart';

class DashboardProvider extends InheritedWidget {
  final DashboardBloc dashboardBloc;

  DashboardProvider({
    DashboardService dashboardService,
    Key key,
    DashboardBloc dashboardBloc,
    Widget child,
  })  : dashboardBloc = dashboardBloc ?? DashboardBloc(dashboardService),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static DashboardBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(DashboardProvider)
              as DashboardProvider)
          .dashboardBloc;
}
