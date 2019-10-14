import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shortener_app/src/dashboard/dashboard_bloc_page.dart';
import 'package:shortener_app/src/login/login_bloc_page.dart';
import 'package:shortener_app/src/session/session_provider.dart';

class LoadingPage extends StatefulWidget {
  static const routeName = "/login";

  @override
  LoadingPageState createState() => LoadingPageState();
}

class LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    final sessionProvider = SessionProvider.of(context);

    // Verify if store token is valid
    sessionProvider.isTokenValid();
    sessionProvider.isValid.listen((tokenValidOrNot) {
      // If it is valid, send user to the Dashboard page,
      // otherwise they'll have to login again.
      if (tokenValidOrNot) {
        Navigator.pushReplacementNamed(context, DashboardBlocPage.routeName);
      } else {
        Navigator.pushReplacementNamed(context, LoginBlocPage.routeName);
      }
    });

    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/logo.png'),
      ),
    );

    Widget _loadingSpinner() {
        return Column(
          children: <Widget>[
            CircularProgressIndicator(
              backgroundColor: Colors.cyan,
            ),
            Text("Loading...")
          ],
        );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            _loadingSpinner(),
            SizedBox(height: 8.0),
            SizedBox(height: 8.0),
            SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }
}
