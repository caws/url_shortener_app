import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  static const routeName = "/login";

  @override
  LoadingPageState createState() => LoadingPageState();
}

class LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
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
