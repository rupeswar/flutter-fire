import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire/screens/settings.dart';
import 'package:flutter_fire/services/email_auth.dart';
import 'package:flutter_fire/widgets/custom_button.dart';
import 'package:flutter_fire/widgets/custom_text_field.dart';

enum PageView { SignUp, Login }

class SignInSignUpAuth extends StatefulWidget {
  @override
  _SignInSignUpAuthState createState() => _SignInSignUpAuthState();
}

class _SignInSignUpAuthState extends State<SignInSignUpAuth> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  PageView _pageView = PageView.Login;

  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController confirmPasswordEditingController =
      TextEditingController();

  @override
  void dispose() {
    emailEditingController.dispose();
    passwordEditingController.dispose();
    confirmPasswordEditingController.dispose();
    super.dispose();
  }

  String validator(String value) {
    if (passwordEditingController.text !=
            confirmPasswordEditingController.text &&
        passwordEditingController.text != '' &&
        confirmPasswordEditingController.text != '')
      return 'Passwords do not match';
    else if (passwordEditingController.text != '' &&
        _pageView == PageView.Login)
      return null;
    else if (passwordEditingController.text ==
            confirmPasswordEditingController.text &&
        passwordEditingController.text != '')
      return null;
    else
      return 'Passwords do not match.';
  }

  @override
  Widget build(BuildContext context) {
    var heightPiece = MediaQuery.of(context).size.height / 10;
    var widthPiece = MediaQuery.of(context).size.width / 10;

    return Scaffold(
      appBar: appBar(context),
      backgroundColor: Colors.teal[400],
      body: Padding(
        padding: EdgeInsets.all(widthPiece),
        child: Form(
          key: _formKey,
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: _buildCircleAvatar(heightPiece),
              ),
              SizedBox(height: 20),
              _buildEmailTextField(),
              SizedBox(height: 25),
              _buildPasswordTextField(),
              SizedBox(height: 25),
              _pageView == PageView.SignUp
                  ? _buildConfirmPasswordTextField()
                  : Container(),
              _pageView == PageView.SignUp ? SizedBox(height: 25) : Container(),
              _buildFlatButton(),
              SizedBox(height: 25),
              _buildButton(context),
            ],
          ),
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: Text(
        'LogIn Screen Using Email',
      ),
      actions: [
        IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (BuildContext context) => SettingsPage(),
                ),
              );
            }),
      ],
    );
  }

  _buildCircleAvatar(double heightPiece) {
    return CircleAvatar(
      backgroundColor: Colors.teal[400],
      radius: heightPiece * 1.5,
      child: Image(
        image: AssetImage('assets/images/flutterfire.png'),
      ),
    );
  }

  _buildEmailTextField() {
    return CustomTextField(
      controller: emailEditingController,
      hintText: 'Email',
      inputType: TextInputType.emailAddress,
    );
  }

  _buildPasswordTextField() {
    return CustomTextField(
      validator: validator,
      controller: passwordEditingController,
      hintText: 'Password',
      obscureText: true,
    );
  }

  _buildConfirmPasswordTextField() {
    return CustomTextField(
      validator: validator,
      controller: confirmPasswordEditingController,
      hintText: 'Confirm Password',
      obscureText: true,
    );
  }

  _buildFlatButton() {
    return FlatButton(
      child:
          Text('Switch to ${_pageView == PageView.Login ? 'SignUp' : 'Login'}'),
      onPressed: () {
        setState(() {
          _pageView =
              _pageView == PageView.Login ? PageView.SignUp : PageView.Login;
          confirmPasswordEditingController.clear();
        });
      },
    );
  }

  _buildButton(BuildContext context) {
    return CustomButton(
      text: _pageView == PageView.Login ? 'Login' : 'Sign Up',
      textColor: Colors.white,
      onPressed: () {
        if (_formKey.currentState.validate()) {
          _pageView == PageView.Login
              ? EmailAuth().signInUser(
                  email: emailEditingController.text,
                  password: passwordEditingController.text,
                  context: context,
                )
              : EmailAuth().createUser(
                  email: emailEditingController.text,
                  password: passwordEditingController.text,
                  context: context,
                );
        }
        print(emailEditingController.text);
        print(passwordEditingController.text);
        print(confirmPasswordEditingController.text);
      },
    );
  }
}
