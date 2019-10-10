import 'package:flutter/widgets.dart';
import 'package:shortener_app/common/services/url.dart';
import 'package:shortener_app/src/url/url_bloc.dart';

/// This is an InheritedWidget that wraps around [UrlBloc]. Think about this
/// as Scoped Model for that specific class.
///
/// This merely solves the "passing reference down the tree" problem for us.
/// You can solve this in other ways, like through dependency injection.
///
/// Also note that this does not call [UrlBloc.dispose]. If your app
/// ever doesn't need to access the cart, you should make sure it's
/// disposed of properly.
class UrlProvider extends InheritedWidget {
  final UrlBloc urlBloc;

  UrlProvider({
    UrlService urlService,
    Key key,
    UrlBloc urlBloc,
    Widget child,
  })  : urlBloc = urlBloc ?? UrlBloc(urlService),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static UrlBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(UrlProvider) as UrlProvider)
          .urlBloc;
}
