import 'package:flutcommerce/core/constants.dart';
import 'package:flutcommerce/utilities/utils.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  FocusNode textFieldFocus = FocusNode();
  TextEditingController _username;
  TextEditingController _email;
  TextEditingController _password;
  TextEditingController _confirmPassword;
  bool _obscure;
  bool _obscureConform;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _username = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();
    _obscure = true;
    _obscureConform = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final UserRepository _userRepository = context.watch<UserRepository>();
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            //Username
            Container(
              margin: EdgeInsets.only(left: 40, right: 40.0, top: 30.0),
              color: bgCol,
              child: TextFormField(
                validator: (val) {
                  if (val.isEmpty) return "*Name is required";
                  return null;
                },
                controller: _username,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(
                    color: textFieldCol,
                  ),
                  hintText: "Enter your name",
                  hintStyle: TextStyle(color: textFieldCol),
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                  focusedBorder: OutlineInputBorder(),
                ),
                cursorColor: mainCol,
              ),
            ),
            //Username
            Container(
              margin: EdgeInsets.only(left: 40, right: 40.0, top: 30.0),
              color: bgCol,
              child: TextFormField(
                validator: (val) {
                  if (val.isEmpty) return "*Email is required";
                  return null;
                },
                controller: _email,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    color: textFieldCol,
                  ),
                  hintText: "Enter your Email",
                  hintStyle: TextStyle(color: textFieldCol),
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                  focusedBorder: OutlineInputBorder(),
                ),
                cursorColor: mainCol,
              ),
            ),
            //Password
            Container(
              margin: EdgeInsets.only(left: 40, right: 40.0, top: 20.0),
              child: TextFormField(
                validator: (val) {
                  if (val.isEmpty) return "*Password is required";
                  return null;
                },
                controller: _password,
                obscureText: _obscure,
                obscuringCharacter: "*",
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: _obscure
                        ? Icon(
                            Icons.visibility,
                            color: textFieldCol,
                          )
                        : Icon(
                            Icons.visibility_off,
                            color: mainCol,
                          ),
                    onPressed: () {
                      setState(() {
                        _obscure = !_obscure;
                      });
                    },
                  ),
                  labelText: "Password",
                  labelStyle: TextStyle(
                    color: textFieldCol,
                  ),
                  hintText: 'Enter your password',
                  hintStyle: TextStyle(color: textFieldCol),
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                  focusedBorder: OutlineInputBorder(),
                ),
                cursorColor: mainCol,
              ),
            ),
            //Conform Password
            Container(
              margin: EdgeInsets.only(left: 40, right: 40.0, top: 20.0),
              child: TextFormField(
                validator: (val) {
                  if (val.isEmpty) return "*Confirm Password is required";
                  return null;
                },
                controller: _confirmPassword,
                obscureText: _obscureConform,
                obscuringCharacter: "*",
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: _obscure
                        ? Icon(
                            Icons.visibility,
                            color: textFieldCol,
                          )
                        : Icon(
                            Icons.visibility_off,
                            color: mainCol,
                          ),
                    onPressed: () {
                      setState(() {
                        _obscureConform = !_obscureConform;
                      });
                    },
                  ),
                  labelText: "Password",
                  labelStyle: TextStyle(
                    color: textFieldCol,
                  ),
                  hintText: 'Enter your password',
                  hintStyle: TextStyle(color: textFieldCol),
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                  focusedBorder: OutlineInputBorder(),
                ),
                cursorColor: mainCol,
              ),
            ),
            //SignUp Button
            const SizedBox(height: 20.0),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.4,
              child: RaisedButton(
                color: mainCol,
                textColor: bgCol,
                child: Text("Create Account"),
                onPressed: () async {
                  Utils.hideKeyboard(textFieldFocus);
                  if (_formKey.currentState.validate()) {
                    if (_confirmPassword.text == _password.text) {
                      // await _userRepository.signUp(
                      //     _email.text, _password.text, _username.text);
                    } else {
                      Utils.showToast(
                          "Password and Confirm Password doesn't match");
                    }
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
