import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mvvm/pages/auth/signin/signin_vm.dart';
import 'package:mvvm/util/logger.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final FocusNode _focusNode = FocusNode();
  bool isPhone = true;
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
                      "Hesabını oluştur",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "İsim",
                        errorMaxLines: 3,
                        suffixIcon:
                            getStatusIcon(context.watch<SignInVM>().nameValid),
                      ),
                      onChanged: context.read<SignInVM>().setName,
                    ),
                    Focus(
                      onFocusChange: (hasFocus) {
                        if (hasFocus) {
                          context.read<SignInVM>().phoneOrMail(isPhone);
                          Log.i("Focus Phone");
                        } else {
                          context.read<SignInVM>().phoneOrMail(null);
                        }
                      },
                      child: TextField(
                        focusNode: _focusNode,
                        keyboardType: isPhone
                            ? TextInputType.number
                            : TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: getPhoneOrMailText(
                                context.watch<SignInVM>().isPhone),
                            errorMaxLines: 3,
                            suffixIcon: context.watch<SignInVM>().isPhone ==
                                    null
                                ? null
                                : getStatusIcon(
                                    context.watch<SignInVM>().phoneOrMailValid),
                            errorText: context.watch<SignInVM>().isPhone == null
                                ? null
                                : context
                                    .watch<SignInVM>()
                                    .phoneOrMailValidate),
                        onChanged: context.read<SignInVM>().setEmail,
                      ),
                    ),
                    const TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Doğum  tarihi",
                          errorMaxLines: 3,
                        )),
                    const Spacer(),
                    Row(
                      children: [
                        if (context.watch<SignInVM>().isPhone != null)
                          TextButton(
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                isPhone = !isPhone;
                                context.read<SignInVM>().phoneOrMail(isPhone);
                                Future.delayed(Duration.zero).then((v) {
                                  FocusScope.of(context)
                                      .requestFocus(_focusNode);
                                });
                                setState(() {});
                              },
                              child: Text(isPhone
                                  ? "E-posta kullan"
                                  : "Telefon kullan")),
                        const Spacer(),
                        ElevatedButton(
                            onPressed: context.watch<SignInVM>().isDone
                                ? () {
                                    // Navigator.pushReplacementNamed(context, "/");
                                  }
                                : null,
                            child: const Text("İleri")),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  String getPhoneOrMailText(bool? flag) {
    if (flag == null) {
      return "Telefon veya e-posta";
    } else {
      return flag == true ? "Telefon" : "E-posta";
    }
  }

  Icon? getStatusIcon(bool? flag) {
    if (flag == null) {
      return null;
    } else {
      return flag == true
          ? const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
            )
          : const Icon(
              Icons.cancel_outlined,
              color: Colors.red,
            );
    }
  }
}
