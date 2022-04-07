import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';
import 'package:qureos/providers/auth.dart';
//widgets
import '../../main_screen.dart';
import '/screens/common/custom_textfield.dart';
// Providers

class SignupForm extends StatefulWidget {
  SignupForm({Key? key, this.isPopup = false, this.isProfile = false})
      : super(key: key);
  bool isPopup;
  bool isProfile;
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> formData = {
    "name": "",
    "email": "",
    "password": "",
  };

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> login(BuildContext context) async {
    var validate = _formKey.currentState!.validate();
    if (validate) {
      _formKey.currentState!.save();
      try {
        setState(() {
          _isLoading = true;
        });
        Future.delayed(const Duration(seconds: 2), () {
          Provider.of<AuthProvider>(context, listen: false).signup(
            formData
          );
          setState(() {
            _isLoading = false;
          });
          ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Signup Successful')));
        });
        
        
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('An error occured')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      duration: Duration(milliseconds: 500),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Text(
              'SignUp',
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            CustomTextfield(
              fieldName: 'Name',
              keyboardType: TextInputType.name,
              passwordField: false,
              onSavedFn: (value) => formData["name"] = value!,
              validatorFn: (value) {
                if (value == "") {
                  return 'Please enter name';
                } else {
                  return null;
                }
              },
            ),
            CustomTextfield(
              fieldName: 'Email',
              keyboardType: TextInputType.emailAddress,
              passwordField: false,
              controller: _emailController,
              onSavedFn: (value) => formData["email"] = value!,
              validatorFn: (value) {
                if (value == "") {
                  return 'Please enter email';
                } else {
                  return null;
                }
              },
            ),
            CustomTextfield(
              fieldName: 'Password',
              keyboardType: TextInputType.text,
              passwordField: true,
              controller: _passwordController,
              onSavedFn: (value) => formData["password"] = value!,
              validatorFn: (value) {
                if (value == "") {
                  return 'Please enter password';
                } else {
                  return null;
                }
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: TextButton(
                      onPressed: () =>
                          Provider.of<AuthProvider>(context, listen: false)
                              .changeMode(AuthMode.ForgotPassword),
                      child: Text("Forgot Password")),
                ),
                SizedBox(width: 160),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: TextButton(
                      onPressed: () =>
                          Provider.of<AuthProvider>(context, listen: false)
                              .changeMode(AuthMode.Login),
                      child: Text("Login")),
                ),
              ],
            ),
            Container(
                width: 350,
                height: 50,
                margin: EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).primaryColor,
                ),
                child: _isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                        color: Colors.white,
                      ))
                    : TextButton(
                        onPressed: () => login(context),
                        child: Text(
                          'SignUp',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )),
            SizedBox(height: 10),
                      SignInButton(
                        
                        Buttons.Google,
                        text: "Sign up with Google",
                        onPressed: () {},
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.symmetric(horizontal: 60,vertical: 8), ),

            Spacer(),
            
          ],
        ),
      ),
    );
  }
}
