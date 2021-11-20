import 'package:flutter/material.dart';
import 'package:mvvm/pages/auth/auth.dart';
import 'package:mvvm/pages/auth/auth_container.dart';
import 'package:mvvm/pages/auth/login/login.dart';
import 'package:mvvm/pages/auth/signin/signin.dart';
import 'package:mvvm/pages/home/home.dart';
import 'package:mvvm/pages/web_view.dart';

extension BuildConttextEx on BuildContext {
  T routeArgs<T>() => ModalRoute.of(this)?.settings.arguments as T;
}

abstract class BaseRoute {
  static GlobalKey<NavigatorState> mainNavigatorKey =
      GlobalKey<NavigatorState>();
  static NavigatorState? get navigator => mainNavigatorKey.currentState;
}

class AppRoute extends BaseRoute {
  static Route onGenerrateRoute(RouteSettings routeSettings) {
    bool fullscreenDialog = false;
    late WidgetBuilder widgetBuilder;

    switch (routeSettings.name) {
      case "auth":
        fullscreenDialog = true;
        widgetBuilder = (_) => const AuthContainer();
        break;
      case "/":
        widgetBuilder = (_) => const HomePage();
        break;
      default:
        widgetBuilder = (_) => Container();
    }

    return MaterialPageRoute(
        builder: widgetBuilder,
        settings: routeSettings,
        fullscreenDialog: fullscreenDialog);
  }
}

class AuthRoute {
  static Route onGenerrateRoute(RouteSettings routeSettings) {
    bool fullscreenDialog = false;
    late WidgetBuilder widgetBuilder;

    switch (routeSettings.name) {
      case "/":
        widgetBuilder = (_) => const AuthPage();
        break;
      case "/signin":
        widgetBuilder = (_) => const SignInPage();
        break;
      case "/login":
        widgetBuilder = (_) => const LoginPage();
        break;
      case "/webview":
        widgetBuilder = (c) => WebViewPage(url: c.routeArgs());
        break;
      default:
        widgetBuilder = (_) => Container();
    }
    return MaterialPageRoute(
        builder: widgetBuilder,
        settings: routeSettings,
        fullscreenDialog: fullscreenDialog);
  }
}
