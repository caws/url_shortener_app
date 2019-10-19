import 'package:flutter/widgets.dart';
import 'package:shortener_app/common/services/dashboard.dart';
import 'package:shortener_app/common/services/login.dart';
import 'package:shortener_app/common/services/session.dart';
import 'package:shortener_app/common/services/signup.dart';
import 'package:shortener_app/common/services/url.dart';
import 'package:shortener_app/src/dashboard/dashboard_bloc.dart';
import 'package:shortener_app/src/error/error_bloc.dart';
import 'package:shortener_app/src/loading/loading_bloc.dart';
import 'package:shortener_app/src/login/login_bloc.dart';
import 'package:shortener_app/src/session/session_bloc.dart';
import 'package:shortener_app/src/signup/signup_bloc.dart';
import 'package:shortener_app/src/url/url_bloc.dart';

class AppProvider extends InheritedWidget {
  final SessionBloc sessionBloc;
  final DashboardBloc dashboardBloc;
  final UrlBloc urlBloc;
  final LoginBloc loginBloc;
  final SignUpBloc signUpBloc;
  final LoadingBloc loadingBloc;
  final ErrorBloc errorBloc;

  AppProvider({
    SessionService sessionService,
    DashboardService dashboardService,
    UrlService urlService,
    LoginService loginService,
    SignupService signupService,
    Key key,
    SessionBloc sessionBloc,
    DashboardBloc dashboardBloc,
    UrlBloc urlBloc,
    LoginBloc loginBloc,
    SignUpBloc signUpBloc,
    LoadingBloc loadingBloc,
    ErrorBloc errorBloc,
    Widget child,
  })  : sessionBloc = sessionBloc ?? SessionBloc(sessionService),
        dashboardBloc =
            dashboardBloc ?? DashboardBloc(dashboardService),
        urlBloc = urlBloc ?? UrlBloc(urlService),
        loginBloc = loginBloc ?? LoginBloc(loginService),
        signUpBloc = signUpBloc ?? SignUpBloc(signupService),
        loadingBloc = loadingBloc ?? LoadingBloc(),
        errorBloc = errorBloc ?? ErrorBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static SessionBloc sessionBlocFrom(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(AppProvider) as AppProvider)
          .sessionBloc;

  static DashboardBloc dashboardBlocFrom(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(AppProvider) as AppProvider)
          .dashboardBloc;

  static UrlBloc urlBlocFrom(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(AppProvider) as AppProvider)
          .urlBloc;

  static LoginBloc loginBlocFrom(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(AppProvider) as AppProvider)
          .loginBloc;

  static SignUpBloc signupBlocFrom(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(AppProvider) as AppProvider)
          .signUpBloc;

  static LoadingBloc loadingBlocFrom(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(AppProvider) as AppProvider)
          .loadingBloc;

  static ErrorBloc errorBlocFrom(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(AppProvider) as AppProvider)
          .errorBloc;
}
