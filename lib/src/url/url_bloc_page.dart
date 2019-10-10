import 'package:flutter/material.dart';
import 'package:shortener_app/common/models/url.dart';
import 'package:shortener_app/src/url/url_provider.dart';

// This class holds the View
class UrlBlocPage extends StatelessWidget {
  UrlBlocPage();

  static const routeName = "/urls";

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
            if (snapshot.data?.isEmpty ?? true) {
              return Center(
                  child: RaisedButton(
                padding: const EdgeInsets.all(8.0),
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: url.getUrls,
                child: new Text("Load Data"),
              ));
            }

            return ListView(
                children: snapshot.data
                    .map((item) => GestureDetector(
                          onTap: () {
                            url.getUrl(item.id);
                          },
                          child: Card(
                            elevation: 3.0,
                            child: Text(item.fullUrl),
                          ),
                        ))
                    .toList());
          }),
    );
  }
}
