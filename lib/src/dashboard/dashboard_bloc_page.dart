import 'package:flutter/material.dart';
import 'package:shortener_app/common/models/dashboard.dart';
import 'package:shortener_app/src/dashboard/dashboard_provider.dart';

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
      appBar: AppBar(
        title: Text("Dashboard"),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                print('sugoi');
              },
              icon: Stack(
                overflow: Overflow.visible,
                children: [
                  Icon(Icons.add),
                ],
              )),
        ],
      ),
      body: StreamBuilder<Dashboard>(
          stream: dashboardProvider.dashboard,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }

            if (snapshot.data == null) {
              return Text('No data');
            }

            return _buildUrls(context, snapshot.data);
          }),
    );
  }
}
