import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Icon(
            Iconsax.home5,
            color: Theme.of(context).primaryColor,
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                      Expanded(
                        child: Center(
                          child: Text(
                            "Şu anda  dünyada olup bitenleri gör.",
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                ?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true)
                              .pushNamedAndRemoveUntil("/", (route) => false);
                        },
                        icon: const Icon(Iconsax.gallery),
                        label: const Text("Google ile devam et"),
                        style: TextButton.styleFrom(
                          minimumSize: const Size.fromHeight(kToolbarHeight),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 1.0,
                            ),
                            borderRadius: const BorderRadius.all(
                                Radius.circular(kToolbarHeight / 2)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextButton.icon(
                        icon: const Icon(Iconsax.sms),
                        onPressed: () {},
                        label: const Text("Apple ile devam et"),
                        style: TextButton.styleFrom(
                          minimumSize: const Size.fromHeight(kToolbarHeight),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 1.0,
                            ),
                            borderRadius: const BorderRadius.all(
                                Radius.circular(kToolbarHeight / 2)),
                          ),
                        ),
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          const Divider(),
                          Container(
                              padding: const EdgeInsets.all(8),
                              color: Theme.of(context).scaffoldBackgroundColor,
                              child: Text(
                                "veya",
                                style: Theme.of(context).textTheme.overline,
                              ))
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/signin");
                        },
                        child: const Text("Hesap oluştur"),
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(kToolbarHeight)),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      RichText(
                        text: TextSpan(
                            style: Theme.of(context).textTheme.bodyText2,
                            children: [
                              const TextSpan(text: "Kaydolarak "),
                              WidgetSpan(
                                  child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, "/webview",
                                      arguments: "https://twitter.com/tos");
                                },
                                child: const Text(
                                  "Hizmet Şartlarımızı",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              )),
                              const TextSpan(text: ", "),
                              WidgetSpan(
                                  child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, "/webview",
                                      arguments: "https://twitter.com/privacy");
                                },
                                child: const Text(
                                  "Gizlilik Politikamızı",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              )),
                              const TextSpan(text: " ve "),
                              WidgetSpan(
                                  child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, "/webview",
                                      arguments:
                                          "https://help.twitter.com/rules-and-policies/twitter-cookies");
                                },
                                child: const Text(
                                  "Çerez Kullanımı Politikamızı",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              )),
                              const TextSpan(text: " kabul etmiş olursunuz.")
                            ]),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      RichText(
                        text: TextSpan(
                            text: "Zaten bir hesabın var mı?",
                            style: Theme.of(context).textTheme.bodyText2,
                            children: [
                              WidgetSpan(
                                  child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, "/login");
                                },
                                child: const Text(
                                  " Giriş yap",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              )),
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
