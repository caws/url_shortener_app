import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shortener_app/common/screens/shared/http_error_widget.dart';
import 'package:shortener_app/src/app/app_provider.dart';
import 'package:shortener_app/src/login/login_bloc_page.dart';
import 'package:shortener_app/src/signup/signup_bloc.dart';

class SignupBlocPage extends StatefulWidget {
  static const routeName = "/signup";

  @override
  SignupBlocPageState createState() => SignupBlocPageState();
}

class SignupBlocPageState extends State<SignupBlocPage> {
  bool isLoading = false;
  HttpErrorWidget errorWidget = HttpErrorWidget(
    dioError: null,
  );
  TextEditingController _name = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Future _handleLogin(BuildContext context, SignUpBloc signupBloc) async {
    _loading();
    _setErrors(null);

    signupBloc.signUp(_name.text, _email.text, _password.text);
    signupBloc.signup.listen((data) {
      if (data != null) {
        Navigator.pushNamed(context, LoginBlocPage.routeName);
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
    final signupBloc = AppProvider.signupBlocFrom(context);

    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/logo_shrtnr.png'),
      ),
    );

    final name = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller: _name,
      decoration: InputDecoration(
        hintText: 'Name',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
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

    final alreadyHaveAnAccount = FlatButton(
      child: Text(
        'Already have an account?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    Widget signupButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () async {
          _handleLogin(context, signupBloc);
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Sign Up', style: TextStyle(color: Colors.white)),
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
            name,
            SizedBox(height: 8.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            signupButton,
            alreadyHaveAnAccount
          ],
        ),
      ),
    );
  }
}
