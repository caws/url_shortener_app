import 'package:flutter/material.dart';
import 'package:shortener_app/src/app/app_provider.dart';

// This class holds the View
class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dashboardBloc = AppProvider.dashboardBlocFrom(context);
    // Taking the UrlProvider from the context
    return Scaffold(
      appBar: AppBar(
        title: Text("My Dashboard"),
      ),
      body: Text('crap'),
    );
  }
}
