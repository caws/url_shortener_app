import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:shortener_app/common/models/dashboard.dart';
import 'package:shortener_app/common/services/dashboard.dart';
import 'package:shortener_app/src/app/app_bloc.dart';

/// This component encapsulates the logic of fetching products from
/// a database, page by page, according to position in an infinite list.
///
/// Only the data that are close to the current location are cached, the rest
/// are thrown away.
class DashboardBloc extends AppBloc {
  final DashboardService _dashboardService;

  // These are the internal objects whose streams / sinks are provided
  // by this component. See below for what each means.
  final _dashboard = BehaviorSubject<Dashboard>();

  DashboardBloc(this._dashboardService);

  ValueObservable<Dashboard> get dashboard => _dashboard.stream;

  Future getDashboard() async {
    cleanUp();
    try {
      super.isLoading();

      final dashboard = await _dashboardService.requestDashboard();
      _dashboard.sink.add(dashboard);

      super.isNotLoading();
    } catch (e) {
      super.setError(e);
      _dashboard.addError(e);

      super.isNotLoading();
    }
  }

  void _cleanUp() {
    _dashboard.sink.add(null);
    super.cleanUp();
  }

  /// Take care of closing streams.
  void dispose() {
    _dashboard.close();
    super.dispose();
  }
}
