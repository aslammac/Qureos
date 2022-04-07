import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:provider/provider.dart';
import 'package:qureos/providers/auth.dart';
//widgets
import '../../main_screen.dart';
import '/screens/common/custom_textfield.dart';
// Providers

class LoginForm extends StatefulWidget {
  LoginForm({Key? key, this.isPopup = false, this.isProfile = false})
      : super(key: key);
  bool isPopup;
  bool isProfile;

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> formData = {
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
          Provider.of<AuthProvider>(context, listen: false).signin(
            formData["email"]??"",
            formData["password"]??"",
          );
          setState(() {
            _isLoading = false;
          });
        });
        

        
      } catch (e) {
        print(e);
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  void googleSignInFun() async{
    final googleSignIn = MockGoogleSignIn();
    final signinAccount = await googleSignIn.signIn();
    final googleAuth = await signinAccount!.authentication;
    // ignore: unused_local_variable
    
    final user = MockUser(
      isAnonymous: false,
      uid: 'someuid',
      email: 'bob@somedomain.com',
      displayName: 'Bob',
    );
    final auth = MockFirebaseAuth(mockUser: user);

   
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
              'Login',
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            CustomTextfield(
              fieldName: 'Email',
              keyboardType: TextInputType.emailAddress,
              passwordField: false,
              // controller: _emailController,
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
              // controller: _passwordController,
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
                              .changeMode(AuthMode.Signup),
                      child: Text("SignUp")),
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
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),),
                      SizedBox(height: 10),
                      SignInButton(
                        
                        Buttons.Google,
                        text: "Sign in with Google",
                        onPressed: () => googleSignInFun(),
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
