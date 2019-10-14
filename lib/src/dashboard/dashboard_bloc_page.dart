import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shortener_app/common/models/dashboard.dart';
import 'package:shortener_app/src/dashboard/dashboard_provider.dart';
import 'package:shortener_app/src/login/login_bloc_page.dart';
import 'package:shortener_app/src/session/session_provider.dart';

// This class holds the View
class DashboardBlocPage extends StatelessWidget {
  DashboardBlocPage();

  static const routeName = "/dashboard";

  Widget _buildUrls(BuildContext context, Dashboard dashboard) {
    final urls = dashboard.recentUrls;
    return Center(
      child: Column(
        children: <Widget>[
          Text("Total: ${dashboard.totalHits}"),
          Container(
            child: ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: urls == null ? 0 : urls.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    elevation: 3.0,
                    child: ListTile(
                      subtitle: Text('Short: ' + urls[index].shortUrl),
                      title: Text(urls[index].fullUrl),
                      leading:
                          Text('Hits:' + urls[index].hitCounter.toString()),
                      trailing: IconButton(
                        icon: Icon(Icons.content_copy),
                        onPressed: () {
                          print('sugoiioii');
                        },
                      ),
                    ));
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Taking the UrlProvider from the context
    final dashboardProvider = DashboardProvider.of(context);
    dashboardProvider.getDashboard();
    return Scaffold(
      body: StreamBuilder<Dashboard>(
          stream: dashboardProvider.dashboard,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }

            if (snapshot.data == null) {
              return Text('No data');
            }

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
                        'Dashboard',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        "Hi Charles",
                        style: TextStyle(),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          FlatButton(
                            child: Icon(
                              Icons.view_list,
                              color: Colors.white,
                            ),
                            color: Theme.of(context).accentColor,
                            onPressed: () {
                            },
                          ),
                          SizedBox(width: 10),
                          FlatButton(
                            child: Icon(
                              Icons.exit_to_app,
                              color: Colors.white,
                            ),
                            color: Colors.red,
                            onPressed: () {
                              final sessionProvider = SessionProvider.of(context);
                              sessionProvider.discardSessionData();

                              Navigator.pushReplacementNamed(context, LoginBlocPage.routeName);
                            },
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
                                  "${snapshot.data.totalHits}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Total Hits",
                                  style: TextStyle(),
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  '1',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Url(s)",
                                  style: TextStyle(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Popular Urls',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 3),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        primary: false,
                        padding: EdgeInsets.all(5),
                        itemCount: snapshot.data.recentUrls.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 200 / 200,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Container(
                              child: GestureDetector(
                                onTap: () {
                                  print("Pression");
                                },
                                child: Card(
                                  elevation: 3.0,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 0.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            IconButton(
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                              iconSize: 20.0,
                                              color: Colors.red,
                                              onPressed: () {},
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              "${snapshot.data.recentUrls[index].shortUrl}",
                                              style: TextStyle(),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Text(
                                              'Hits:',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            Text(
                                              "${snapshot.data.recentUrls[index].hitCounter}",
                                              style: TextStyle(),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Text(
                                              'Hits:',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            Text(
                                              "${snapshot.data.recentUrls[index].hitCounter}",
                                              style: TextStyle(),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              height: 190.0,
                              width: MediaQuery.of(context).size.width - 100.0,
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
