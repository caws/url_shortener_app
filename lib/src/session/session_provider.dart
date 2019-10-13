import 'package:flutter/widgets.dart';
import 'package:shortener_app/common/services/session.dart';

import 'session_bloc.dart';

class SessionProvider extends InheritedWidget {
  final SessionBloc sessionBloc;

  SessionProvider({
    SessionService sessionService,
    Key key,
    SessionBloc sessionBloc,
    Widget child,
  })  : sessionBloc = sessionBloc ?? SessionBloc(sessionService),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static SessionBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(SessionProvider) as SessionProvider)
          .sessionBloc;
}
