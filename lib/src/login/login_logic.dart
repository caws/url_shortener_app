import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:shortener_app/src/app/app_provider.dart';
import 'package:shortener_app/src/dashboard/dashboard_bloc_page.dart';

class LoginLogic {
  final BuildContext context;

  LoginLogic(this.context);

  Future handleLogin(String email, password) async {
    // Dismiss the keyboard when the login button is tapped
    FocusScope.of(context).requestFocus(FocusNode());

    // Access blocs that are going to be used.
    final errorBloc = AppProvider.errorBlocFrom(context);
    final loginBloc = AppProvider.loginBlocFrom(context);
    final loadingBloc = AppProvider.loadingBlocFrom(context);

    // The LoadingBLoc is set to loading mode, thus every LoadingBlocPage
    // widget shows the CircularProgressButton.
    loadingBloc.setLoading();

    // Try to login
    loginBloc.doLogin(email, password);

    final subscription = loginBloc.login.listen(null);
    subscription.onData((handleData) async {
      if (handleData != null) {
        subscription.cancel();
        loadingBloc.setNotLoading();
        final sessionProvider = AppProvider.sessionBlocFrom(context);
        sessionProvider.setSessionData(handleData);
        await Navigator.pushReplacementNamed(
            context, DashboardBlocPage.routeName);
      }
    });

    subscription.onError((handleError) {
      errorBloc.setError((handleError));
      subscription.cancel();
      loadingBloc.setNotLoading();
    });
  }
}
