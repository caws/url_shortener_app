import 'package:rxdart/rxdart.dart';

class LoadingBloc {
  // These are the internal objects whose streams / sinks are provided
  // by this component. See below for what each means.
  final _isLoading = BehaviorSubject<bool>.seeded(false);

  LoadingBloc();

  ValueObservable<bool> get isLoading => _isLoading.stream;

  void setLoading() {
    _isLoading.sink.add(true);
  }

  void setNotLoading() {
    _isLoading.sink.add(false);
  }

  /// Take care of closing streams.
  void dispose() {
    _isLoading.close();
  }
}
