import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shortener_app/common/screens/shared/http_error_widget.dart';
import 'package:shortener_app/src/app/app_provider.dart';
import 'package:shortener_app/src/dashboard/dashboard_bloc_page.dart';
import 'package:shortener_app/src/signup/signup_bloc_page.dart';

import 'login_bloc.dart';

class LoginBlocPage extends StatefulWidget {
  static const routeName = "/login";

  @override
  LoginBlocPageState createState() => LoginBlocPageState();
}

class LoginBlocPageState extends State<LoginBlocPage> {
  bool isLoading = false;
  HttpErrorWidget errorWidget = HttpErrorWidget(
    dioError: null,
  );
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Future _handleLogin(BuildContext context, LoginBloc loginBloc) async {
    _loading();
    _setErrors(null);

    loginBloc.doLogin(_email.text, _password.text);
    loginBloc.login.listen((data) {
      if (data != null) {
        _setErrors(null);
        _notLoading();
        final sessionProvider = AppProvider.sessionBlocFrom(context);
        sessionProvider.setSessionData(data);
        Navigator.pushReplacementNamed(context, DashboardBlocPage.routeName);
      } else {
        _notLoading();
      }
    }, onError: (error) {
      _setErrors(error);
      _notLoading();
    });
  }

  void _setErrors(DioError e) {
    setState(() {
      errorWidget = HttpErrorWidget(dioError: e);
    });
  }

  void _loading() {
    setState(() {
      isLoading = true;
    });
  }

  void _notLoading() {
    setState(() {
      isLoading = false;
    });
  }

  Widget _loadingSpinner() {
    if (isLoading) {
      return Column(
        children: <Widget>[
          CircularProgressIndicator(
            backgroundColor: Colors.cyan,
          ),
          Text("Loading...")
        ],
      );
    }

    return SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    final loginBloc = AppProvider.loginBlocFrom(context);

    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/logo_shrtnr.png'),
      ),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller: _email,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      controller: _password,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final newUser = FlatButton(
      child: Text(
        'New User?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        Navigator.pushNamed(context, SignupBlocPage.routeName);
      },
    );

    Widget loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () async {
          _handleLogin(context, loginBloc);
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Log In', style: TextStyle(color: Colors.white)),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            _loadingSpinner(),
            errorWidget,
            SizedBox(height: 8.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            loginButton,
            newUser
          ],
        ),
      ),
    );
  }
}
