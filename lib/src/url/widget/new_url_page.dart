import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shortener_app/common/models/url.dart';
import 'package:shortener_app/common/screens/shared/http_error_widget.dart';
import 'package:shortener_app/src/app/app_provider.dart';
import 'package:shortener_app/src/loading/loading_bloc_page.dart';
import 'package:shortener_app/src/url/url_bloc.dart';

// This class holds the View
class NewUrlPage extends StatefulWidget {
  static const routeName = "/new_url";

  @override
  _NewUrlPageState createState() => _NewUrlPageState();
}

class _NewUrlPageState extends State<NewUrlPage> {
  HttpErrorWidget errorWidget = HttpErrorWidget(
    dioError: null,
  );
  final TextEditingController controllerFullUrl = new TextEditingController();
  final TextEditingController controllerDescription =
      new TextEditingController();

  Future _handleSave(UrlBloc urlBloc, BuildContext context) async {
    await urlBloc.saveUrl(Url(
        fullUrl: controllerFullUrl.text,
        description: controllerDescription.text));

    final subscription = urlBloc.url.listen(null);
    subscription.onData((handleData) {
      subscription.cancel();
      if (handleData != null) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final urlBloc = AppProvider.urlBlocFrom(context);

    Widget _newUrlForm(AsyncSnapshot<Url> snapshot, List<Widget> uiComponents) {
      return Scaffold(
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: uiComponents))),
      );
    }

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            FloatingActionButton(
              heroTag: 'back',
              highlightElevation: 22,
              child: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FloatingActionButton(
              heroTag: 'save',
              backgroundColor: Colors.green,
              highlightElevation: 22,
              child: Icon(Icons.save),
              onPressed: () async {
                _handleSave(urlBloc, context);
              },
            )
          ],
        ),
        body: StreamBuilder<Url>(
            stream: urlBloc.url,
            builder: (context, snapshot) {
              List<Widget> uiComponents = List();
              uiComponents.add(SizedBox(height: 40));
              uiComponents.add(Text(
                'New Url',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ));

              if (snapshot.hasError) {
                uiComponents.add(HttpErrorWidget(
                  dioError: snapshot.error,
                ));
              }

              uiComponents.add(TextFormField(
                controller: controllerFullUrl,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: "Full URL"),
              ));

              uiComponents.add(TextFormField(
                controller: controllerDescription,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: "Description"),
              ));

              return _newUrlForm(snapshot, uiComponents);
            }));
  }
}
