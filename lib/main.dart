import 'package:flutter/material.dart';
import 'package:shortener_app/common/services/url.dart';
import 'package:shortener_app/common/theme/theme.dart';
import 'package:shortener_app/src/url/url_bloc.dart';
import 'package:shortener_app/src/url/url_bloc_page.dart';
import 'package:shortener_app/src/url/url_provider.dart';

void main() {
  // Initiate services.
  final urlService = UrlService();

  // Build top-level components.
  // In a real world app, this would also rope in HTTP clients and such.
  final urlBloc = UrlBloc(urlService);

  // Start the app.
  runApp(MyApp(urlBloc));
}

class MyApp extends StatelessWidget {
  final UrlBloc urlBloc;

  MyApp(this.urlBloc);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return UrlProvider(
      urlBloc: urlBloc,
      child: MaterialApp(
        title: 'Url Shortener',
        theme: appTheme,
        home: UrlBlocPage(),
      ),
    );
  }
}