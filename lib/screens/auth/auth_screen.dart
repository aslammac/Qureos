import 'package:flutter/material.dart';
import 'package:qureos/providers/auth.dart';
import 'package:qureos/screens/auth/components/forgot_form.dart';
import 'package:qureos/screens/auth/components/signup_form.dart';

// Widgets
import 'components/login_form.dart';
//Providers
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({Key? key, this.isPopup = false, this.isProfile = false})
      : super(key: key);
  bool isPopup;
  bool isProfile;

  @override
  Widget build(BuildContext context) {
    AuthMode mode = Provider.of<AuthProvider>(context).mode;
    return Scaffold(
      // backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(),
          child: AnimatedSwitcher(
            switchInCurve: Curves.linear,
            reverseDuration: Duration(milliseconds: 500),
            duration: Duration(milliseconds: 500),
            child: mode == AuthMode.Login
                ? LoginForm(isPopup: isPopup, isProfile: isProfile)
                : mode == AuthMode.Signup
                    ? SignupForm(isPopup: isPopup, isProfile: isProfile)
                    : ForgotForm(isPopup: isPopup, isProfile: isProfile),
          ),
        ),
      ),
    );
  }
}
