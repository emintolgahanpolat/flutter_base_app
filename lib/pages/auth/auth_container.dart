import 'package:flutter/material.dart';
import 'package:mvvm/pages/auth/login/login_vm.dart';
import 'package:mvvm/pages/auth/signin/signin_vm.dart';
import 'package:mvvm/router.dart';
import 'package:provider/provider.dart';

class AuthContainer extends StatelessWidget {
  const AuthContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SignInVM>(create: (_) => SignInVM()),
        ChangeNotifierProvider<LoginVM>(create: (_) => LoginVM()),
      ],
      child: const Navigator(
        initialRoute: "/",
        onGenerateRoute: AuthRoute.onGenerrateRoute,
      ),
    );
  }
}
