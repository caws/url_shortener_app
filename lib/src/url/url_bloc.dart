import 'dart:async';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shortener_app/common/models/url.dart';
import 'package:shortener_app/common/services/url.dart';

/// This component encapsulates the logic of fetching products from
/// a database, page by page, according to position in an infinite list.
///
/// Only the data that are close to the current location are cached, the rest
/// are thrown away.
class UrlBloc {
  // This is the internal state. It's mostly a helper object so that the code
  // in this class only deals with streams.
  final UrlService _urlService;

  // These are the internal objects whose streams / sinks are provided
  // by this component. See below for what each means.
  final _urls = BehaviorSubject<List<Url>>(seedValue: []);
  final _url = BehaviorSubject<Url>();
  final _urlsCount = BehaviorSubject<int>(seedValue: 0);
  final _error = BehaviorSubject<Exception>();
  bool errorPresent = false;

  UrlBloc(this._urlService);

  /// This is the stream of items in the cart. Use this to show the contents
  /// of the cart when you need all the information in [CartItem].
  ValueObservable<List<Url>> get urls => _urls.stream;

  ValueObservable<Exception> get error => _error.stream;

  Future getUrls() async {
    try {
      final urls = await _urlService.requestAll();
      _urls.sink.add(urls);
      _urlsCount.sink.add(urls.length);
    } catch (e) {
      _error.sink.add(e);
    }
  }

  // Tries to get data, if something
  // unexpected happens, add exception
  // to the sink.
  Future getUrl(int urlId) async {
    try {
      final url = await _urlService.requestById(urlId);
      _url.sink.add(url);
    } catch (e) {
      _error.sink.add(e);
    }
  }

  ValueObservable<int> get urlsCount => _urlsCount.stream;

  /// Take care of closing streams.
  void dispose() {
    _url.close();
    _urls.close();
    _urlsCount.close();
    _error.close();
  }
}
