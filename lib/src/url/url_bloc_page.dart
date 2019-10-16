import 'package:flutter/material.dart';
import 'package:shortener_app/common/models/url.dart';
import 'package:shortener_app/src/url/url_provider.dart';
import 'package:shortener_app/src/url/widget/new_url_page.dart';
import 'package:shortener_app/src/url/widget/url_page.dart';

// This class holds the View
class UrlBlocPage extends StatelessWidget {
  static const routeName = "/urls";

  @override
  Widget build(BuildContext context) {
    // Taking the UrlProvider from the context
    final urlsProvider = UrlProvider.of(context);
    urlsProvider.getUrls();
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
            heroTag: 'add',
            backgroundColor: Colors.blueAccent,
            highlightElevation: 22,
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, NewUrlPage.routeName);
            },
          )
        ],
      ),
      body: StreamBuilder<List<Url>>(
          stream: urlsProvider.urls,
          builder: (context, snapshot) {
//            if (snapshot.hasError) {
//              return Text(snapshot.error.toString());
//            }
//
//            if (snapshot.data == null) {
//              return Text('No data');
//            }

            return Scaffold(
              body: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 40),
                      Text(
                        'My Urls',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 3),
                      snapshot.data == null || snapshot.hasError == true ? Text("No Data") : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        primary: false,
                        padding: EdgeInsets.only(top: 5, left:5, right: 5, bottom: 90),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        UrlPage(
                                          url: snapshot.data[index],
                                          urlBloc: urlsProvider,
                                        )),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.all(0.0),
                              child: Container(
                                child: Card(
                                  elevation: 3.0,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 0.0),
                                    child: ListTile(
                                      leading: Text("${snapshot.data[index].shortUrl}", style: TextStyle(fontWeight: FontWeight.bold),),
                                      title: Text("${snapshot.data[index].urlSample()}"),
                                      trailing: IconButton(
                                        color: Colors.red,
                                        icon: Icon(
                                            Icons.delete
                                        ),
                                        onPressed: () async {
                                          await urlsProvider.delete(
                                              snapshot.data[index]);
                                          await urlsProvider.getUrls();
                                        },
                                      ),
                                      subtitle: Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              Text("Hits:", style: TextStyle(fontWeight: FontWeight.bold),),
                                              Text("${snapshot.data[index].hitCounter}")
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              Text("Status:", style: TextStyle(fontWeight: FontWeight.bold),),
                                              Text("${snapshot.data[index].status}")
                                            ],
                                          )
                                        ],
                                      ),
                                      isThreeLine: true,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
