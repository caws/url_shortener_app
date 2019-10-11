import 'package:rxdart/rxdart.dart';

class AbstractBloc {
  final _error = BehaviorSubject<Exception>();

  ValueObservable<Exception> get error => _error.stream;

  void dispose() {
    _error.close();
  }
}
