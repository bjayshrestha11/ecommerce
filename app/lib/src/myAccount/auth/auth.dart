import 'package:app/constants/strings.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:app/constants/colors.dart';
import 'package:app/enums/authState.dart';
import 'package:app/resources/userRepository.dart';
import 'package:app/src/myAccount/auth/signIn.dart';
import 'package:app/src/myAccount/auth/signUp.dart';
import 'package:app/utilities/utils.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  bool signInForm;
  void tooggle() {
    setState(() {
      signInForm = !signInForm;
    });
  }

  @override
  void initState() {
    super.initState();
    signInForm = true;
  }

  @override
  Widget build(BuildContext context) {
    final TapGestureRecognizer _gestureRecognizer = TapGestureRecognizer()
      ..onTap = () {
        tooggle();
      };
     //Asynchronous Function For Firebase Login
    googleSignIn() async {
      await context.read<UserRepository>().signInWithGoogle();
    }

    // facebookSignIn() async {
    //   Utils.showToast("Sign In with facebook");
    // }

    return WillPopScope(
      onWillPop: () async {
        if (!signInForm) {
          setState(() {
            signInForm = true;
          });
          return false;
        } else {
          return true;
        }
      },
      child: SafeArea(
        child: Scaffold(
          key: _key,
          backgroundColor: bgCol,
          body: SingleChildScrollView(
            child: Column(
              children: [
                //App Name or Logo
                Container(
                  width: Utils.getWidthByPercentage(context, 100),
                  height: Utils.getHeightByPercentage(context, 24),
                  margin: EdgeInsets.only(top: 15.0),
                  child: Image.asset(
                    logo,
                  ),
                ),
                //Loading Progress Bar while Authenticating
                context.watch<UserRepository>().status == Status.Authenticating
                    ? Center(
                        child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      ))
                    : Padding(padding: EdgeInsets.all(1.0)),
                //Form for login or SignIn
                AnimatedSwitcher(
                  child: signInForm ? SignIn() : SignUp(),
                  duration: Duration(milliseconds: 200),
                ),
                SizedBox(
                  height: 20,
                  child: Center(
                    child: Text(
                      "or",
                      style: TextStyle(color: textFieldCol),
                    ),
                  ),
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    //Login With Google
                    buildButton(
                      'Google',
                      FontAwesomeIcons.google,
                      Colors.orange,
                      Colors.white,
                      googleSignIn,
                    ),
                    // //Login With Facebook
                    // buildButton('facebook', FontAwesomeIcons.facebook,
                    //     Colors.indigo, Colors.blue, facebookSignIn),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 30.0),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 18),
                      children: <TextSpan>[
                        TextSpan(
                          text: signInForm
                              ? "Not yet a member, "
                              : "Already a member, ",
                          style: TextStyle(color: textFieldCol, fontSize: 12.0),
                        ),
                        TextSpan(
                          text: signInForm ? "Sign Up" : "Sign In",
                          style: TextStyle(
                              fontSize: 13.0,
                              color: mainCol,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold),
                          recognizer: _gestureRecognizer,
                        ),
                      ],
                    ),
                  ),
                ),
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Back",
                      style: TextStyle(
                        color: mainCol,
                        decoration: TextDecoration.underline,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildButton(String platForm, IconData icon, Color iconColor,
      Color bgCol, Function func) {
    return Container(
      width: Utils.getWidthByPercentage(context, 44),
      height: 55.0,
      // margin: EdgeInsets.only(left: 40.0),
      padding: EdgeInsets.all(10.0),
      // width: 160.0,
      child: RaisedButton.icon(
        onPressed: func,
        icon: Icon(
          icon,
          color: iconColor,
          size: 19.0,
        ),
        label: Text(
          '$platForm',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 3,
        color: bgCol,
      ),
    );
  }
}
