import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:shortener_app/common/models/authentication.dart';
import 'package:shortener_app/common/services/session.dart';

class SessionBloc {
  final SessionService _sessionService;

  // These are the internal objects whose streams / sinks are provided
  // by this component. See below for what each means.
  final _sessionToken = BehaviorSubject<String>();
  final _isLogged = BehaviorSubject<bool>();
  final _isValid = BehaviorSubject<bool>();

  SessionBloc(this._sessionService);

  ValueObservable<String> get sessionToken => _sessionToken.stream;
  ValueObservable<bool> get isLogged => _isLogged.stream;
  ValueObservable<bool> get isValid => _isValid.stream;

  Future isUserLogged() async {
    try {
      // Call the
      final isLogged = await _sessionService.isLogged();
      _isLogged.sink.add(isLogged);
    } catch (e) {
      _isLogged.addError(e);
    }
  }
  
  isTokenValid() async {
    try {
      // Call the
      final isValid = await _sessionService.isTokenValid();
      _isValid.sink.add(isValid);
    } catch (e) {
      _isLogged.addError(e);
    }
  }
  
  getToken() async {
    try {
      // Call the
      final token = await _sessionService.getToken();
      _sessionToken.sink.add(token);
    } catch (e) {
      _sessionToken.addError(e);
    }
  }

  setToken(String token) async {
    try {
      // Call the
      final result = _sessionService.storeToken(token);
    } catch (e) {
      _sessionToken.addError(e);
    }
  }


  /// Take care of closing streams.
  void dispose() {
    _sessionToken.close();
    _isLogged.close();
    _isValid.close();
  }
}
