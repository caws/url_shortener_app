import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:shortener_app/common/models/dashboard.dart';
import 'package:shortener_app/common/models/url.dart';
import 'package:shortener_app/common/services/dashboard.dart';
import 'package:shortener_app/common/services/session.dart';
import 'package:shortener_app/common/services/url.dart';

/// This component encapsulates the logic of fetching products from
/// a database, page by page, according to position in an infinite list.
///
/// Only the data that are close to the current location are cached, the rest
/// are thrown away.
class DashboardBloc {
  final DashboardService _dashboardService;

  // These are the internal objects whose streams / sinks are provided
  // by this component. See below for what each means.
  final _dashboard = BehaviorSubject<Dashboard>();

  DashboardBloc(this._dashboardService);

  ValueObservable<Dashboard> get dashboard => _dashboard.stream;

  Future getDashboard() async {
    try {
      final dashboard = await _dashboardService.requestDashboard();
      _dashboard.sink.add(dashboard);
    } catch (e) {
      _dashboard.addError(e);
    }
  }

  /// Take care of closing streams.
  void dispose() {
    _dashboard.close();
  }
}
