import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:shortener_app/common/models/user.dart';
import 'package:shortener_app/common/services/signup.dart';

class SignUpBloc {
  final SignupService _signUpService;

  // These are the internal objects whose streams / sinks are provided
  // by this component. See below for what each means.
  final _signUp = BehaviorSubject<User>();

  SignUpBloc(this._signUpService);

  ValueObservable<User> get login => _signUp.stream;

  Future signUp(String email, String password) async {
    try {
      _signUp.sink.add(null);
      final signUp = await _signUpService.signup(email, password);
      _signUp.sink.add(signUp);
    } catch (e) {
      _signUp.sink.addError(e);
    }
  }

  /// Take care of closing streams.
  void dispose() {
    _signUp.close();
  }
}
