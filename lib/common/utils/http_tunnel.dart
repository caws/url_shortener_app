// This is a wrapper class for an http client
// Created so that the client can easily be replaced
// without having to change stuff anywhere else in the package.

import 'package:dio/dio.dart';
import 'dart:async';

import 'package:shortener_app/common/services/session.dart';

class HttpTunnel<T> {
  final dio = new Dio();
  final SessionService _sessionService;
  Options options = new Options();

  HttpTunnel(this._sessionService);

  Future<Response<T>> get(String url) async {
    await setAuthorizationToken();

    return await dio.get(url, options: this.options);
  }

  Future<Response<T>> post(String url, dynamic data) async {
    await setAuthorizationToken();

    return await dio.post(url, options: this.options, data: data);
  }

  Future<Response<T>> patch(String url, dynamic data) async {
    await setAuthorizationToken();

    return await dio.patch(url, options: this.options, data: data);
  }

  Future<Response<T>> delete(String url, dynamic data) async {
    await setAuthorizationToken();

    return await dio.delete(url, options: this.options, data: data);
  }

  Future setAuthorizationToken() async {
    final sessionData = await _sessionService.getSessionData();
    Map<String, dynamic> headers = new Map();

    headers["Authorization"] = "Bearer ${sessionData.token}";

    this.options.headers = headers;
  }
}
