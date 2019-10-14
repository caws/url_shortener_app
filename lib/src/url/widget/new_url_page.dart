import 'package:flutter/material.dart';
import 'package:shortener_app/common/models/url.dart';
import 'package:shortener_app/src/dashboard/dashboard_bloc_page.dart';
import 'package:shortener_app/src/url/url_bloc.dart';
import 'package:shortener_app/src/url/url_provider.dart';
import 'package:shortener_app/src/url/widget/url_page.dart';

// This class holds the View
class NewUrlPage extends StatefulWidget {
  static const routeName = "/new_url";

  @override
  _NewUrlPage createState() => _NewUrlPage();
}

class _NewUrlPage extends State<NewUrlPage> {
  bool isLoading = false;
  String errorMessage = '';
  final TextEditingController controllerFullUrl = new TextEditingController();

  void setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  Widget _loadingSpinner() {
    if (isLoading) {
      return Column(
        children: <Widget>[
          CircularProgressIndicator(
            backgroundColor: Colors.cyan,
          ),
          Text("Loading...")
        ],
      );
    }

    return SizedBox();
  }

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

  @override
  Widget build(BuildContext context) {
    final urlsProvider = UrlProvider.of(context);

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
              onPressed: () {
                setLoading(true);
                urlsProvider.url.drain();
                urlsProvider.saveUrl(Url(fullUrl: controllerFullUrl.text));

                urlsProvider.url.listen((onData) {
                  setLoading(false);
                  Navigator.pushReplacementNamed(
                      context, DashboardBlocPage.routeName);
                }, onError: (error) {
                  setLoading(false);
                });
              },
            )
          ],
        ),
        body: StreamBuilder<Url>(
            stream: urlsProvider.url,
            builder: (context, snapshot) {

//              if (snapshot.data != null) {
//                return Text("Sugoi");
//              }

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
                uiComponents.add(Text(snapshot.error.toString()));
              }
              uiComponents.add(_loadingSpinner());

              uiComponents.add(TextFormField(
                controller: controllerFullUrl,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: "Full URL"),
              ));

              return _newUrlForm(snapshot, uiComponents);
            }));
  }
}
