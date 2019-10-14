import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:shortener_app/common/models/url.dart';
import 'package:shortener_app/common/services/url.dart';

/// This component encapsulates the logic of fetching products from
/// a database, page by page, according to position in an infinite list.
///
/// Only the data that are close to the current location are cached, the rest
/// are thrown away.
class UrlBloc {
  final UrlService _urlService;

  // These are the internal objects whose streams / sinks are provided
  // by this component. See below for what each means.
  final _urls = BehaviorSubject<List<Url>>(seedValue: []);

  final _url = BehaviorSubject<Url>();
  final _urlsCount = BehaviorSubject<int>(seedValue: 0);

  UrlBloc(this._urlService);

  ValueObservable<Url> get url => _url.stream;

  ValueObservable<List<Url>> get urls => _urls.stream;
  ValueObservable<int> get urlsCount => _urlsCount.stream;

  Future getUrls() async {
    try {
      final urls = await _urlService.requestAll();
      _urls.sink.add(urls);
      _urlsCount.sink.add(urls.length);
    } catch (e) {
      _urls.addError(e);
    }
  }

  Future saveUrl(Url newUrl) async {
    try {
      final url = await _urlService.save(newUrl);
      _url.sink.add(url);
    } catch (e) {
      _url.addError(e);
    }
  }

  Future delete(Url deadUrl) async {
    try {
      final url = _urlService.delete(deadUrl);
      _url.drain();
    } catch (e) {
      _url.addError(e);
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
      _url.addError(e);
    }
  }


  /// Take care of closing streams.
  void dispose() {
    _url.close();
    _urls.close();
    _urlsCount.close();
  }
}
