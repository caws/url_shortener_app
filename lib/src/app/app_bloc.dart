import 'package:rxdart/rxdart.dart';

class AppBloc {
  final _loading = BehaviorSubject<bool>();
  final _error = BehaviorSubject<Exception>();

  ValueObservable<bool> get loading => _loading.stream;
  ValueObservable<Exception> get error => _error.stream;

  void cleanUp() {
    _error.sink.add(null);
    _loading.sink.add(false);
  }

  void isLoading() {
    _loading.sink.add(true);
  }

  void isNotLoading() {
    _loading.sink.add(false);
  }

  void setError(Exception exception) {
    _error.sink.add(exception);
  }

  /// Take care of closing streams.
  void dispose() {
    _loading.close();
    _error.close();
  }
}
