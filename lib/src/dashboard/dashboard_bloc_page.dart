import 'package:flutter/material.dart';
import 'package:shortener_app/common/models/dashboard.dart';
import 'package:shortener_app/src/dashboard/dashboard_provider.dart';
import 'package:shortener_app/src/url/url_provider.dart';

// This class holds the View
class DashboardBlocPage extends StatelessWidget {
  DashboardBlocPage();

  static const routeName = "/dashboard";

  Widget onSuccess(BuildContext context, Dashboard dashboard) {
    return Text(dashboard.totalHits.toString());
  }

  @override
  Widget build(BuildContext context) {
    // Taking the UrlProvider from the context
    final dashboardProvider = DashboardProvider.of(context);
    dashboardProvider.getDashboard();
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: StreamBuilder<Dashboard>(
          stream: dashboardProvider.dashboard,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("NANI");
            }

            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text('No connection');
              case ConnectionState.waiting:
                return Text("Loading");
              case ConnectionState.active:
                return onSuccess(context, snapshot.data);
              case ConnectionState.done:
                return Text('Connection closed');
            }
            return null; // unreachable
          }),
    );
  }
}
