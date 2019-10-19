import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shortener_app/common/screens/shared/http_error_widget.dart';
import 'package:shortener_app/src/app/app_provider.dart';

class ErrorBlocPage extends StatefulWidget {
  @override
  ErrorBlocPageState createState() => ErrorBlocPageState();
}

class ErrorBlocPageState extends State<ErrorBlocPage> {
  @override
  Widget build(BuildContext context) {
    final errorBloc = AppProvider.errorBlocFrom(context);

    return StreamBuilder<DioError>(
        stream: errorBloc.error,
        builder: (context, snapshot) {
          if ((snapshot.data != null)) {
            if (snapshot.data is DioError) {
              return HttpErrorWidget(dioError: snapshot.data);
            }

            return Text(snapshot.error.toString());
          }

          return SizedBox();
        });
  }
}
