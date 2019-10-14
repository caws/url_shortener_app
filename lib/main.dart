import 'package:flutter/material.dart';
import 'package:shortener_app/common/services/login.dart';
import 'package:shortener_app/common/services/session.dart';
import 'package:shortener_app/common/services/url.dart';
import 'package:shortener_app/common/theme/theme.dart';
import 'package:shortener_app/common/utils/http_tunnel.dart';
import 'package:shortener_app/src/dashboard/dashboard_bloc.dart';
import 'package:shortener_app/src/dashboard/dashboard_bloc_page.dart';
import 'package:shortener_app/src/dashboard/dashboard_provider.dart';
import 'package:shortener_app/src/login/login_bloc.dart';
import 'package:shortener_app/src/login/login_bloc_page.dart';
import 'package:shortener_app/src/login/login_provider.dart';
import 'package:shortener_app/src/session/session_bloc.dart';
import 'package:shortener_app/src/session/session_provider.dart';
import 'package:shortener_app/src/url/url_bloc.dart';
import 'package:shortener_app/src/url/url_bloc_page.dart';
import 'package:shortener_app/src/url/url_provider.dart';
import 'package:shortener_app/src/url/widget/new_url_page.dart';
import 'package:shortener_app/src/url/widget/url_page.dart';

import 'common/screens/loading_page.dart';
import 'common/services/dashboard.dart';

void main() {
  // Initiate services.
  final sessionService = SessionService();
  // Initiate HTTP service.
  HttpTunnel httpTunnel = HttpTunnel(sessionService);

  final loginService = LoginService(httpTunnel);
  final urlService = UrlService(httpTunnel);
  final dashboardService = DashboardService(httpTunnel);

  // Build top-level components.
  // In a real world app, this would also rope in HTTP clients and such.
  final loginBloc = LoginBloc(loginService);
  final urlBloc = UrlBloc(urlService);
  final dashboardBloc = DashboardBloc(dashboardService);
  final sessionBloc = SessionBloc(sessionService);

  // Start the app.
  runApp(MyApp(urlBloc, dashboardBloc, loginBloc, sessionBloc));
}

class MyApp extends StatelessWidget {
  final UrlBloc urlBloc;
  final DashboardBloc dashboardBloc;
  final LoginBloc loginBloc;
  final SessionBloc sessionBloc;

  MyApp(this.urlBloc, this.dashboardBloc, this.loginBloc, this.sessionBloc);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    sessionBloc.isTokenValid();

    Widget _loginPage() {
      return LoginProvider(
        loginBloc: loginBloc,
        child: LoginBlocPage(),
      );
    }

    Widget _dashboardPage() {
      return DashboardProvider(
        dashboardBloc: dashboardBloc,
        child: DashboardBlocPage(),
      );
    }

    return SessionProvider(
      sessionBloc: sessionBloc,
      child: MaterialApp(
        title: 'Url Shortener',
        theme: appTheme,
        home: StreamBuilder<bool>(
            stream: sessionBloc.isValid,
            builder: (context, snapshot) {
              // If there's an error, user is redirected to the LoginPage
              if (snapshot.hasError) {
                return _loginPage();
              }

              // If data is null and no errors are present, this
              // means that we're waiting for something to happen.
              if (snapshot.data == null) {
                return LoadingPage();
              }

              // If the data returned is true, it means that the
              // session is valid (token is present)
              if (snapshot.data) {
                return _dashboardPage();
              }

              // Otherwise we'll just send the user to the login
              // screen because their token is invalid/expired.
              return _loginPage(); // unreachable
            }),
        routes: <String, WidgetBuilder>{
          LoginBlocPage.routeName: (context) => LoginProvider(
                loginBloc: loginBloc,
                child: LoginBlocPage(),
              ),
          UrlBlocPage.routeName: (context) => UrlProvider(
                urlBloc: urlBloc,
                child: UrlBlocPage(),
              ),
          NewUrlPage.routeName: (context) => UrlProvider(
                urlBloc: urlBloc,
                child: NewUrlPage(),
              ),
          DashboardBlocPage.routeName: (context) => DashboardProvider(
                dashboardBloc: dashboardBloc,
                child: DashboardBlocPage(),
              ),
        },
      ),
    );
  }
}
