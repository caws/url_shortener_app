import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class HttpErrorWidget extends StatelessWidget {
  final DioError dioError;

  const HttpErrorWidget({Key key, this.dioError}) : super(key: key);

  Widget _errorColumn() {
    List<Text> texts = List();

    (dioError.response.data as LinkedHashMap).entries.forEach((entry) {
      texts.add(Text("${entry.key} ${entry.value}"));
    });

    return Column(
      children: texts,
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (dioError == null) {
      return SizedBox();
    }

    if (dioError.response == null) {
      return Center(
        child: Text(dioError.message),
      );
    }

    return Center(
      child: _errorColumn(),
    );
  }
}
