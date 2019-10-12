import 'package:flutter/widgets.dart';
import 'package:shortener_app/common/services/dashboard.dart';
import 'package:shortener_app/common/services/login.dart';

import 'login_bloc.dart';

class LoginProvider extends InheritedWidget {
  final LoginBloc loginBloc;

  LoginProvider({
    LoginService loginService,
    Key key,
    LoginBloc loginBloc,
    Widget child,
  })  : loginBloc = loginBloc ?? LoginBloc(loginService),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(LoginProvider) as LoginProvider)
          .loginBloc;
}
