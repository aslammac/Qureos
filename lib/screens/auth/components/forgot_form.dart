import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:provider/provider.dart';
import 'package:qureos/providers/auth.dart';
//widgets
import '../../main_screen.dart';
import '/screens/common/custom_textfield.dart';
// Providers

class ForgotForm extends StatefulWidget {
  ForgotForm({Key? key, this.isPopup = false, this.isProfile = false})
      : super(key: key);
  bool isPopup;
  bool isProfile;
  @override
  _ForgotFormState createState() => _ForgotFormState();
}

class _ForgotFormState extends State<ForgotForm> {
  final _emailController = TextEditingController();
  bool _isLoading = false;
  // final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> forgotPassword() async {
    if (_emailController.text != '') {
      try {
        setState(() {
          _isLoading = true;
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Please check mail ' + _emailController.text)));
        setState(() {
          _isLoading = false;
        });
        Provider.of<AuthProvider>(context, listen: false)
            .changeMode(AuthMode.Login);
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          Text(
            'Forgot Password',
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
            controller: _emailController,
            onSavedFn: (value) => null,
            validatorFn: (value) {
              if (value == "") {
                return 'Please enter email';
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
                            .changeMode(AuthMode.Signup),
                    child: Text("SignUp")),
              ),
              SizedBox(width: 220),
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
                      onPressed: () => forgotPassword(),
                      child: Text(
                        'Send Mail',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )),
          Spacer(),
          if (widget.isProfile == false)
            TextButton(
                onPressed: () => widget.isPopup
                    ? Navigator.pop(context)
                    : Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => MainScreen())),
                child: Text("Skip login")),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
