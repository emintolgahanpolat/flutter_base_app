import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mvvm/pages/auth/login/login_vm.dart';
import 'package:mvvm/util/logger.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    Log.i("login");

    super.initState();
  }

  GlobalKey<FormState> formState = GlobalKey();
  @override
  Widget build(BuildContext context) {
    // bool isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
        appBar: AppBar(
          title: const Icon(Iconsax.home5),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        ),
        body: LayoutBuilder(builder: (c, constarint) {
          return SingleChildScrollView(
            child: IntrinsicHeight(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constarint.maxHeight,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Başlamak  için  ilk önce  telefon numaranı, e-posta  adresini veya @kullacınıadını gir",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      TextField(
                        decoration: InputDecoration(
                            hintText:
                                "Telefon numarası, e-posta veya  kullanıcı adı",
                            errorMaxLines: 3,
                            errorText: context.watch<LoginVM>().emailValid),
                        onChanged: context.read<LoginVM>().setEmail,
                      ),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: "Password",
                            errorMaxLines: 3,
                            errorText: context.watch<LoginVM>().passwordValid),
                        onChanged: context.read<LoginVM>().setPassword,
                      ),
                      const Spacer(),
                      ElevatedButton(
                          onPressed: context.watch<LoginVM>().isDone
                              ? () {
                                  // Navigator.pushReplacementNamed(context, "/");
                                }
                              : null,
                          child: const Text("Login")),
                      TextButton(
                          onPressed: () {},
                          child: const Text("Forgot password?"))
                    ],
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
