import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shortener_app/common/models/authentication.dart';
import 'package:shortener_app/common/models/dashboard.dart';
import 'package:shortener_app/common/screens/shared/error_widget.dart';
import 'package:shortener_app/common/screens/shared/loading_widget.dart';
import 'package:shortener_app/src/app/app_provider.dart';
import 'package:shortener_app/src/login/login_bloc_page.dart';
import 'package:shortener_app/src/url/url_bloc_page.dart';
import 'package:shortener_app/src/url/widget/new_url_page.dart';
import 'package:shortener_app/src/url/widget/url_page.dart';

// This class holds the View
class DashboardBlocPage extends StatelessWidget {
  DashboardBlocPage();

  static const routeName = "/dashboard";

  @override
  Widget build(BuildContext context) {
    // Taking the UrlProvider from the context
    final dashboardBloc = AppProvider.dashboardBlocFrom(context);
    final sessionBloc = AppProvider.sessionBlocFrom(context);

    dashboardBloc.getDashboard();
    sessionBloc.getSessionData();
    return Scaffold(
      body: StreamBuilder<Dashboard>(
          stream: dashboardBloc.dashboard,
          builder: (context, snapshot) {
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
                      StreamBuilder<Authentication>(
                          stream: sessionBloc.sessionData,
                          builder: (context, snapshot) {
                            if (snapshot.data == null) {
                              return CircularProgressIndicator(
                                backgroundColor: Colors.blueAccent,
                              );
                            }

                            return Text(
                              "Hi ${snapshot.data.user.name}",
                              style: TextStyle(),
                            );
                          }),
                      SizedBox(height: 20),
                      snapshot.data == null || snapshot.hasError == true
                          ? Column(
                              children: <Widget>[
                                LoadingWidget(
                                  loading: dashboardBloc.loading,
                                  width: 25,
                                  height: 25,
                                ),
                                CustomErrorWidget(
                                  error: dashboardBloc.error,
                                ),
                                Text("No Data")
                              ],
                            )
                          : Column(
                              children: <Widget>[
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
                                        Navigator.pushNamed(
                                            context, UrlBlocPage.routeName);
                                      },
                                    ),
                                    SizedBox(width: 10),
                                    FlatButton(
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                      color: Colors.cyan,
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, NewUrlPage.routeName);
                                      },
                                    ),
                                    SizedBox(width: 10),
                                    FlatButton(
                                      child: Icon(
                                        Icons.exit_to_app,
                                        color: Colors.white,
                                      ),
                                      color: Colors.red,
                                      onPressed: () async {
                                        final sessionBloc =
                                            AppProvider.sessionBlocFrom(
                                                context);
                                        await sessionBloc.discardSessionData();

                                        Navigator.pushReplacementNamed(
                                            context, LoginBlocPage.routeName);
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                CustomErrorWidget(error: dashboardBloc.error,),
                                LoadingWidget(loading: dashboardBloc.loading,height: 30,width: 30,),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 50),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                            "${snapshot.data.numberOfUrls}",
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
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  primary: false,
                                  padding: EdgeInsets.all(0),
                                  itemCount: snapshot.data.recentUrls.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: EdgeInsets.all(0.0),
                                      child: Container(
                                        child: Card(
                                          elevation: 3.0,
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 0.0),
                                            child: ListTile(
                                              leading: Text(
                                                "${snapshot.data.recentUrls[index].shortUrl}",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              title: Text(
                                                  "${snapshot.data.recentUrls[index].urlSample()}"),
                                              trailing: IconButton(
                                                color: Colors.blueAccent,
                                                icon: Icon(Icons.search),
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            UrlPage(
                                                                url: snapshot
                                                                        .data
                                                                        .recentUrls[
                                                                    index])),
                                                  );
                                                },
                                              ),
                                              subtitle: Column(
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: <Widget>[
                                                      Text(
                                                        "Hits:",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                          "${snapshot.data.recentUrls[index].hitCounter}")
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: <Widget>[
                                                      Text(
                                                        "Status:",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                          "${snapshot.data.recentUrls[index].status}")
                                                    ],
                                                  )
                                                ],
                                              ),
                                              isThreeLine: true,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                )
                              ],
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
