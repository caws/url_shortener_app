import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shortener_app/common/screens/loading_page.dart';
import 'package:shortener_app/common/theme/theme.dart';
import 'package:shortener_app/src/error/error_bloc.dart';
import 'package:shortener_app/src/loading/loading_bloc_page.dart';
import 'package:shortener_app/src/session/session_bloc.dart';
import 'package:shortener_app/src/signup/signup_bloc.dart';
import 'package:shortener_app/src/signup/signup_bloc_page.dart';
import 'package:shortener_app/src/url/url_bloc.dart';
import 'package:shortener_app/src/url/url_bloc_page.dart';
import 'package:shortener_app/src/url/widget/new_url_page.dart';

import 'app/app_provider.dart';
import 'dashboard/dashboard_bloc.dart';
import 'dashboard/dashboard_bloc_page.dart';
import 'loading/loading_bloc.dart';
import 'login/login_bloc.dart';
import 'login/login_bloc_page.dart';

class ShortenerApp extends StatelessWidget {
  final UrlBloc urlBloc;
  final DashboardBloc dashboardBloc;
  final LoginBloc loginBloc;
  final SignUpBloc signupBloc;
  final SessionBloc sessionBloc;
  final LoadingBloc loadingBloc;
  final ErrorBloc errorBloc;

  ShortenerApp(this.urlBloc, this.dashboardBloc, this.loginBloc,
      this.sessionBloc, this.signupBloc, this.loadingBloc, this.errorBloc);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    sessionBloc.isTokenValid();

    return AppProvider(
      urlBloc: urlBloc,
      dashboardBloc: dashboardBloc,
      loginBloc: loginBloc,
      sessionBloc: sessionBloc,
      signUpBloc: signupBloc,
      loadingBloc: loadingBloc,
      errorBloc: errorBloc,
      child: MaterialApp(
        title: 'Url Shortener',
        theme: appTheme,
        home: StreamBuilder<bool>(
            stream: sessionBloc.isValid,
            builder: (context, snapshot) {
              // If there's an error, user is redirected to the LoginPage
              if (snapshot.hasError) {
                return LoginBlocPage();
              }

              // If data is null and no errors are present, this
              // means that we're waiting for something to happen.
              if (snapshot.data == null) {
                return LoadingPage();
              }

              // If the data returned is true, it means that the
              // session is valid (token is present)
              if (snapshot.data) {
                return DashboardBlocPage();
              }

              // Otherwise we'll just send the user to the login
              // screen because their token is invalid/expired.
              return LoginBlocPage(); // unreachable
            }),
        routes: <String, WidgetBuilder>{
          LoginBlocPage.routeName: (context) => LoginBlocPage(),
          SignupBlocPage.routeName: (context) => SignupBlocPage(),
          UrlBlocPage.routeName: (context) => UrlBlocPage(),
          NewUrlPage.routeName: (context) => NewUrlPage(),
          DashboardBlocPage.routeName: (context) => DashboardBlocPage()
        },
      ),
    );
  }
}
