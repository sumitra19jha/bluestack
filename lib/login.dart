import 'package:bluestack/Custom_Painters/language_icon.dart';
import 'package:bluestack/Provider/login.dart';
import 'package:bluestack/Utils/color.dart';
import 'package:bluestack/Utils/lang_delegate.dart';
import 'package:bluestack/Utils/page-animation.dart';
import 'package:bluestack/Widgets/raisedRoundedButton.dart';
import 'package:bluestack/Utils/size-config.dart';
import 'package:bluestack/Utils/validator.dart';
import 'package:bluestack/home.dart';
import 'package:bluestack/language.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  FocusNode passwordFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  bool hidePassword = true;
  AutovalidateMode validate = AutovalidateMode.disabled;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            //navigationService.pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          margin: EdgeInsets.fromLTRB(
            SizeConfig.screenWidth * 0.06,
            SizeConfig.screenHeight * 0.02,
            SizeConfig.screenWidth * 0.06,
            0.0,
          ),
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight,
          child: Form(
            key: formKey,
            autovalidateMode: validate,
            child: Column(
              children: <Widget>[
                Image.asset('assets/Images/logo1.png'),
                Container(
                  margin: EdgeInsets.fromLTRB(15, 0, 15, 10),
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(height: 15),
                      TextFormField(
                        controller: phone,
                        focusNode: emailFocus,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        autofillHints: const <String>[AutofillHints.email],
                        enableSuggestions: true,
                        validator: (value) {
                          final String? err = Validator.validatePhone(value!);
                          if (err != null) {
                            return AppLocalizations.of(context)!.translate(err);
                          }

                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!
                              .translate("Phone Hint"),
                          labelText:
                              '${AppLocalizations.of(context)!.translate("Enter your Phone number")} *',
                          labelStyle: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight! * 0.025,
                      ),
                      TextFormField(
                        controller: password,
                        focusNode: passwordFocus,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        enableSuggestions: true,
                        autofillHints: const <String>[AutofillHints.password],
                        obscureText: hidePassword,
                        validator: (value) {
                          final String? err =
                              Validator.validatePassword(value!);
                          if (err != null) {
                            return AppLocalizations.of(context)!.translate(err);
                          }

                          return null;
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                              icon: Icon(hidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility)),
                          hintText: AppLocalizations.of(context)!
                              .translate('password'),
                          labelText:
                              '${AppLocalizations.of(context)!.translate("Enter your password")} *',
                          labelStyle: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight! * 0.086,
                      ),
                      RaisedRoundedButton(
                        buttonLabel:
                            AppLocalizations.of(context)!.translate('Login'),
                        onTap: () async {
                          emailFocus.unfocus();
                          passwordFocus.unfocus();
                          validate = AutovalidateMode.always;
                          if (formKey.currentState!.validate()) {
                            validate = AutovalidateMode.disabled;
                            try {
                              //LOGIN-LOGIC-----------------------------------------------------------
                              await Provider.of<LoginProvider>(
                                context,
                                listen: false,
                              ).login(phone.text, password.text);

                              Navigator.of(context).pushReplacement(
                                PageTransition.show(HomeScreen()),
                              );
                            } catch (e) {
                              print(e);
                            }
                          }
                        },
                        textColor: const Color(0xFF008A37),
                        key: const Key('LoginButton'),
                        backgroundColor: UiColor.lightShades,
                      ),
                      SizedBox(height: SizeConfig.screenHeight! * 0.0215),
                    ],
                  ),
                ),
                const SizedBox(height: 45),
                GestureDetector(
                  key: const Key('ChangeLanguage'),
                  onTap: () {
                    Navigator.of(context).push(
                      PageTransition.show(SelectLanguage()),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: SizeConfig.safeBlockVertical! * 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomPaint(
                          size: Size(
                              SizeConfig.screenWidth! * 0.125,
                              (SizeConfig.screenWidth! * 0.125 * 0.5)
                                  .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                          painter: LanguageIcon(),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          AppLocalizations.of(context)!
                              .translate('Change language'),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
