// This is a wrapper class for an http client
// Created so that the client can easily be replaced
// without having to change stuff anywhere else in the package.

import 'package:dio/dio.dart';
import 'dart:async';

class HttpTunnel<T> {
  final dio = new Dio();
  String url;
  Options options = new Options();

  Future<Response<T>> _returnResponse(dynamic e) async {
    return Future.delayed(Duration(milliseconds: 10), () => e.response);
  }

  Future<Response<T>> get(String url) async {
    return await dio.get(url, options: this.options);
  }

  Future<Response<T>> post(String url, dynamic data) async {
    return await dio.post(url, options: this.options, data: data);
  }

  Future<Response<T>> patch(String url, dynamic data) async {
    return await dio.patch(url, options: this.options, data: data);
  }

  Future<Response<T>> delete(String url, dynamic data) async {
    return await dio.delete(url, options: this.options, data: data);
  }

  void setAuthorizationToken(String token) {
    Map<String, dynamic> headers = new Map();
    headers["Authorization"] = "Bearer " +
        'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1NzA4NDMwOTZ9.QRvFvs1xUqK-NXzT5esO2auvU9Dchd4SclAf-ZIGdP0';
//    headers["Locale"] = "pt-BR";

    this.options.headers = headers;
  }
}
