import 'package:flutter/material.dart';
import 'package:shortener_app/src/dashboard/dashboard_provider.dart';

// This class holds the View
class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dashboardBloc = DashboardProvider.of(context);
    // Taking the UrlProvider from the context
    return Scaffold(
      appBar: AppBar(
        title: Text("My Dashboard"),
      ),
      body: Text('crap'),
    );
  }
}
