import 'dart:async';
import 'dart:collection';
import 'dart:math';
import 'dart:ui';

import 'package:shortener_app/common/models/url.dart';

/// This class consumes the Url Shortener API
class UrlService {
  /// Fetches a single url a database. The [urlId]
  /// parameter is used to build the request.
  Future<Url> requestById(int urlId) async {
    // Simulate network delay.
    await Future.delayed(Duration(milliseconds: 200));

    // Create a single Url object
    return _buildRandomUrl();
  }

  /// Fetches a many urls from the database.
  Future<List<Url>> requestAll() async {
    // Simulate network delay.
    await Future.delayed(Duration(milliseconds: 200));

    List<Url> urls = List<Url>();
    urls.add(_buildRandomUrl());
    urls.add(_buildRandomUrl());
    urls.add(_buildRandomUrl());
    urls.add(_buildRandomUrl());

    return urls;
  }

  // Used for demonstration purposes, won't be in the final versino
  Url _buildRandomUrl() {
    final random = Random();

    final id = random.nextInt(0xffff);
    final shortUrl = 'https://${random.nextInt(50)}.com';
    final fullUrl = 'https://${random.nextInt(50)}.com';
    final pageTitle = 'Google';
    final hitCounter = 50;
    final status = 'Up';
    final createdAt = '2010-10-10';

    return Url(
        id: id,
        shortUrl: shortUrl,
        fullUrl: fullUrl,
        pageTitle: pageTitle,
        hitCounter: hitCounter,
        status: status,
        createdAt: createdAt);
  }
}
