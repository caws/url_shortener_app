import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shortener_app/common/screens/shared/http_error_widget.dart';

class CustomErrorWidget extends StatefulWidget {
  final ValueObservable<Exception> error;

  const CustomErrorWidget({Key key, this.error}) : super(key: key);

  @override
  CustomErrorWidgetState createState() => CustomErrorWidgetState();
}

class CustomErrorWidgetState extends State<CustomErrorWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Exception>(
        stream: widget.error,
        builder: (context, snapshot) {
          if ((snapshot.data != null)) {
            if (snapshot.data is DioError) {
              return HttpErrorWidget(dioError: snapshot.data as DioError);
            }

            return Text(snapshot.error.toString());
          }

          return SizedBox();
        });
  }
}
