import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shortener_app/common/screens/shared/error_widget.dart';
import 'package:shortener_app/common/screens/shared/loading_widget.dart';
import 'package:shortener_app/src/app/app_provider.dart';
import 'package:shortener_app/src/login/login_logic.dart';
import 'package:shortener_app/src/signup/signup_bloc_page.dart';

class LoginBlocPage extends StatefulWidget {
  static const routeName = "/login";

  @override
  LoginBlocPageState createState() => LoginBlocPageState();
}

class LoginBlocPageState extends State<LoginBlocPage> {
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginBLoc = AppProvider.loginBlocFrom(context);
    final loginLogic = LoginLogic(context);

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
          loginLogic.handleLogin(_email.text, _password.text);
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LoadingWidget(loading: loginBLoc.loading,),
            Text('Log In', style: TextStyle(color: Colors.white))
          ],
        ),
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
            CustomErrorWidget(error: loginBLoc.error),
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
