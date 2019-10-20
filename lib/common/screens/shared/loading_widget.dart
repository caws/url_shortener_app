import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shortener_app/src/app/app_provider.dart';

class LoadingWidget extends StatefulWidget {
  final ValueObservable<bool> loading;
  final double height;
  final double width;

  const LoadingWidget({Key key, this.loading, this.height, this.width})
      : super(key: key);

  @override
  LoadingWidgetState createState() => LoadingWidgetState();
}

class LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: widget.loading,
        builder: (context, snapshot) {
          if ((snapshot.data != null) && (snapshot.data)) {
            return Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: SizedBox(
                height: widget.height != null ? widget.height : 15.0,
                width: widget.width != null ? widget.width : 15.0,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.cyan,
                ),
              ),
            );
          }

          return new Container();
        });
  }
}
