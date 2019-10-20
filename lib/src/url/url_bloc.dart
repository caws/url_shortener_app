import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:shortener_app/common/models/url.dart';
import 'package:shortener_app/common/services/url.dart';
import 'package:shortener_app/src/app/app_bloc.dart';

/// This component encapsulates the logic of fetching products from
/// a database, page by page, according to position in an infinite list.
///
/// Only the data that are close to the current location are cached, the rest
/// are thrown away.
class UrlBloc extends AppBloc{
  final UrlService _urlService;

  // These are the internal objects whose streams / sinks are provided
  // by this component. See below for what each means.
  final _urls = BehaviorSubject<List<Url>>();

  final _url = BehaviorSubject<Url>();
  final _urlsCount = BehaviorSubject<int>();

  UrlBloc(this._urlService);

  ValueObservable<Url> get url => _url.stream;

  ValueObservable<List<Url>> get urls => _urls.stream;

  ValueObservable<int> get urlsCount => _urlsCount.stream;

  Future getUrls() async {
    _cleanUp();
    try {
      super.isLoading();
      final urls = await _urlService.requestAll();
      _urls.sink.add(urls);
      _urlsCount.sink.add(urls.length);
      super.isNotLoading();
    } catch (e) {
      _urls.addError(e);
      super.setError(e);
      super.isNotLoading();
    }
  }

  Future saveUrl(Url newUrl) async {
    _cleanUp();
    try {
      super.isLoading();
      _url.sink.add(null);
      final url = await _urlService.save(newUrl);
      _url.sink.add(url);
      super.isNotLoading();
    } catch (e) {
      _url.sink.addError(e);
      super.setError(e);
      super.isNotLoading();
    }
  }

  Future delete(Url deadUrl) async {
    _cleanUp();
    try {
      super.isLoading();
      await _urlService.delete(deadUrl);
      _url.sink.add(null);
      super.isNotLoading();
    } catch (e) {
      _url.addError(e);
      super.setError(e);
      super.isNotLoading();
    }
  }

  // Tries to get data, if something
  // unexpected happens, add exception
  // to the sink.
  Future getUrl(int urlId) async {
    _cleanUp();
    try {
      super.isLoading();
      final url = await _urlService.requestById(urlId);
      _url.sink.add(url);
      super.isNotLoading();
    } catch (e) {
      _url.addError(e);
      super.setError(e);
      super.isNotLoading();
    }
  }

  void _cleanUp() {
    _urls.sink.add(null);
    _url.sink.add(null);
    super.cleanUp();
  }

  /// Take care of closing streams.
  void dispose() {
    _url.close();
    _urls.close();
    _urlsCount.close();
    super.dispose();
  }
}
