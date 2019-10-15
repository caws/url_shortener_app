import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shortener_app/src/dashboard/dashboard_bloc_page.dart';
import 'package:shortener_app/src/login/login_provider.dart';
import 'package:shortener_app/src/session/session_provider.dart';

class LoginBlocPage extends StatefulWidget {
  static const routeName = "/login";

  @override
  LoginBlocPageState createState() => LoginBlocPageState();
}

class LoginBlocPageState extends State<LoginBlocPage> {
  bool isLoading = false;
  String errorMessage = '';

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

  void _setErrors(Exception e) {
    if (e != null) {
      setState(() {
        errorMessage = e.toString();
      });
    } else {
      setState(() {
        errorMessage = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = LoginProvider.of(context);
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/logo.png'),
      ),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      initialValue: 'sugoi@gmail.com',
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      initialValue: '123456',
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () async {
          _loading();

          await loginProvider.doLogin(
              email.initialValue, password.initialValue);

          final subscription = loginProvider.login.listen(null);
          subscription.onData((data) {
            subscription.cancel();
            final sessionProvider = SessionProvider.of(context);
            sessionProvider.setSessionData(data);
            Navigator.pushReplacementNamed(
                context, DashboardBlocPage.routeName);
          });

          subscription.onError((error) {
            _setErrors(error);
            _notLoading();
          });
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Log In', style: TextStyle(color: Colors.white)),
      ),
    );

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

    Widget _errorMessage() {
      if (errorMessage.length > 0) {
        return Center(child: Text(errorMessage));
      }

      return SizedBox();
    }

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
            _errorMessage(),
            SizedBox(height: 8.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            loginButton
          ],
        ),
      ),
    );
  }
}
