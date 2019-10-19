import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

class ErrorBloc {
  // These are the internal objects whose streams / sinks are provided
  // by this component. See below for what each means.
  final _error = BehaviorSubject<DioError>();

  ErrorBloc();

  ValueObservable<DioError> get error => _error.stream;

  void setError(DioError error) {
    _error.sink.add(error);
  }

  void removeError() {
    _error.sink.add(null);
  }

  /// Take care of closing streams.
  void dispose() {
    _error.close();
  }
}
