import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shortener_app/src/app/app_provider.dart';

class LoadingBlocPage extends StatefulWidget {
  final double height;
  final double width;

  const LoadingBlocPage({Key key, this.height, this.width}) : super(key: key);

  @override
  LoadingBlocPageState createState() => LoadingBlocPageState();
}

class LoadingBlocPageState extends State<LoadingBlocPage> {
  @override
  Widget build(BuildContext context) {
    final loadingBloc = AppProvider.loadingBlocFrom(context);

    return StreamBuilder<bool>(
        stream: loadingBloc.isLoading,
        builder: (context, snapshot) {
          if ((snapshot.data != null) && (snapshot.data)) {
            return Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: SizedBox(
                height: widget.height != null ? widget.height : 15.0,
                width: widget.width  != null ? widget.width : 15.0,
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
