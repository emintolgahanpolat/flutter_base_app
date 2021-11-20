import 'package:flutter/material.dart';
import 'package:mvvm/pages/home/home_vm.dart';
import 'package:mvvm/router.dart';
import 'package:mvvm/util/colors.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<HomeVM>(create: (_) => HomeVM()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: AppColors.random.toMaterial(),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
            elevation: 0,
            shape: const RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(kToolbarHeight / 2)),
            ),
          )),
          appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0)),
      initialRoute: "auth",
      onGenerateRoute: AppRoute.onGenerrateRoute,
    );
  }
}
