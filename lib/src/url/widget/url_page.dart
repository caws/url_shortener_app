import 'package:flutter/material.dart';
import 'package:shortener_app/common/models/url.dart';
import 'package:shortener_app/src/dashboard/dashboard_bloc_page.dart';
import 'package:shortener_app/src/url/url_bloc.dart';

import '../url_provider.dart';

// This class holds the View
class UrlPage extends StatefulWidget {
  final Url url;
  final UrlBloc urlBloc;

  UrlPage({this.url, this.urlBloc});

  @override
  _UrlPageState createState() => _UrlPageState();
}

class _UrlPageState extends State<UrlPage> {
  bool isLoading = false;

  void setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  void _handleDelete() {
    setLoading(true);
    widget.urlBloc.delete(widget.url);

    widget.urlBloc.url.listen((onData) {
      setLoading(false);
      Navigator.pushReplacementNamed(
          context, DashboardBlocPage.routeName);
    }, onError: (error) {
      setLoading(false);
    }, onDone: () {
      setLoading(false);
      Navigator.pushReplacementNamed(
          context, DashboardBlocPage.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget _infoLine(String label, String value) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          Text(value)
        ],
      );
    }

    Widget _urlInfo() {
      return Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _infoLine("ID", "${widget.url.id}"),
              SizedBox(height: 5),
              _infoLine("Full URL", "${widget.url.urlSample()}"),
              SizedBox(height: 5),
              _infoLine("Title", "${widget.url.pageTitle}"),
              SizedBox(height: 5),
              _infoLine("Created At", "${widget.url.createdAt}"),
            ],
          ));
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
              heroTag: 'remove',
              backgroundColor: Colors.red,
              highlightElevation: 22,
              child: Icon(Icons.delete),
              onPressed: () {
                _handleDelete();
              },
            )
          ],
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 40),
                      Column(
                        children: <Widget>[
                          Text(
                            "${widget.url.shortUrl}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Short Url",
                            style: TextStyle(),
                          ),
                        ],
                      ),
                      SizedBox(height: 40),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text(
                                  "${widget.url.hitCounter}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Hits",
                                  style: TextStyle(),
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  "${widget.url.status}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Status",
                                  style: TextStyle(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40),
                      Text(
                        "Details",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 10),
                      _urlInfo()
                    ]))));
  }
}
