import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:shortener_app/common/models/authentication.dart';
import 'package:shortener_app/common/services/login.dart';
import 'package:shortener_app/src/app/app_bloc.dart';

class LoginBloc extends AppBloc {
  final LoginService _loginService;

  // These are the internal objects whose streams / sinks are provided
  // by this component. See below for what each means.
  final _login = BehaviorSubject<Authentication>();

  LoginBloc(this._loginService);

  ValueObservable<Authentication> get login => _login.stream;

  Future doLogin(String email, String password) async {
    cleanUp();
    try {
      super.isLoading();
      final login = await _loginService.login(email, password);
      _login.sink.add(login);
      super.isNotLoading();
    } catch (e) {
      super.setError(e);
      _login.sink.addError(e);
      super.isNotLoading();
    }
  }

  void _cleanUp() {
    _login.sink.add(null);
    super.cleanUp();
  }

  /// Take care of closing streams.
  void dispose() {
    _login.close();
    super.dispose();
  }
}
