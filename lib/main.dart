import 'package:flutter/material.dart';
import 'package:shortener_app/common/services/login.dart';
import 'package:shortener_app/common/services/session.dart';
import 'package:shortener_app/common/services/signup.dart';
import 'package:shortener_app/common/services/url.dart';
import 'package:shortener_app/common/utils/http_tunnel.dart';
import 'package:shortener_app/src/app.dart';
import 'package:shortener_app/src/dashboard/dashboard_bloc.dart';
import 'package:shortener_app/src/login/login_bloc.dart';
import 'package:shortener_app/src/session/session_bloc.dart';
import 'package:shortener_app/src/signup/signup_bloc.dart';
import 'package:shortener_app/src/signup/signup_bloc_page.dart';
import 'package:shortener_app/src/url/url_bloc.dart';

import 'common/services/dashboard.dart';

void main() {
  // Initiate services.
  final sessionService = SessionService();
  // Initiate HTTP service.
  HttpTunnel httpTunnel = HttpTunnel(sessionService);

  final loginService = LoginService(httpTunnel);
  final signupService = SignupService(httpTunnel);
  final urlService = UrlService(httpTunnel);
  final dashboardService = DashboardService(httpTunnel);

  // Build top-level components.
  // In a real world app, this would also rope in HTTP clients and such.
  final loginBloc = LoginBloc(loginService);
  final signupBloc = SignUpBloc(signupService);
  final urlBloc = UrlBloc(urlService);
  final dashboardBloc = DashboardBloc(dashboardService);
  final sessionBloc = SessionBloc(sessionService);

  // Start the app.
  runApp(
      ShortenerApp(urlBloc, dashboardBloc, loginBloc, sessionBloc, signupBloc));
}
