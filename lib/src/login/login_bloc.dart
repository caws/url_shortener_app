import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:shortener_app/common/models/authentication.dart';
import 'package:shortener_app/common/services/login.dart';

class LoginBloc {
  final LoginService _loginService;

  // These are the internal objects whose streams / sinks are provided
  // by this component. See below for what each means.
  final _login = BehaviorSubject<Authentication>();

  LoginBloc(this._loginService);

  ValueObservable<Authentication> get login => _login.stream;

  Future doLogin(String email, String password) async {
    try {
      _login.sink.add(null);
      final login = await _loginService.login(email, password);
      _login.sink.add(login);
    } catch (e) {
      _login.sink.addError(e);
    }
  }

  /// Take care of closing streams.
  void dispose() {
    _login.close();
  }
}
