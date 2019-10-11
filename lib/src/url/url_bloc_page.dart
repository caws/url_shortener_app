import 'package:flutter/material.dart';
import 'package:shortener_app/common/models/url.dart';
import 'package:shortener_app/src/url/url_provider.dart';
import 'package:shortener_app/src/url/widget/url_page.dart';

// This class holds the View
class UrlBlocPage extends StatelessWidget {
  UrlBlocPage();

  static const routeName = "/urls";

  Widget onSuccess(BuildContext context, List<Url> urls) {
    return ListView(
        children: urls
            .map((item) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              UrlPage(url: item)),
                    );
                  },
                  child: Card(
                    elevation: 3.0,
                    child: Text(item.fullUrl),
                  ),
                ))
            .toList());
  }

  Widget onEmpty(BuildContext context) {
    final url = UrlProvider.of(context);
    return Center(
        child: RaisedButton(
      padding: const EdgeInsets.all(8.0),
      textColor: Colors.white,
      color: Colors.blue,
      onPressed: url.getUrls,
      child: new Text("Load Data"),
    ));
  }

  Widget onError(BuildContext context, Exception error) {
    final url = UrlProvider.of(context);
    return Column(
      children: <Widget>[
        Text("Houston....${error.toString()}"),
        Center(
            child: RaisedButton(
          padding: const EdgeInsets.all(8.0),
          textColor: Colors.white,
          color: Colors.blue,
          onPressed: url.getUrls,
          child: new Text("Load Data"),
        ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Taking the UrlProvider from the context
    final url = UrlProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Urls"),
      ),
      body: StreamBuilder<List<Url>>(
          stream: url.urls,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return onError(context, snapshot.error);
            }

            if (snapshot.data?.isEmpty ?? true) {
              return onEmpty(context);
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
