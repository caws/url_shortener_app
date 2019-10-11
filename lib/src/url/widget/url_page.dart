import 'package:flutter/material.dart';
import 'package:shortener_app/common/models/url.dart';
import 'package:shortener_app/src/url/url_provider.dart';

// This class holds the View
class UrlPage extends StatelessWidget {
  final Url url;

  UrlPage({this.url});

  @override
  Widget build(BuildContext context) {
    // Taking the UrlProvider from the context
    return Scaffold(
      appBar: AppBar(
        title: Text("Url"),
      ),
      body: Text(url.fullUrl),
    );
  }
}
