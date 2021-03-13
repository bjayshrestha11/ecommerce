import 'package:flutcommerce/core/constants.dart';
import 'package:flutcommerce/utilities/utils.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final FocusNode passwordField = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _email;
  TextEditingController _password;
  bool _obscure;
  FocusNode textFieldFocus = FocusNode();
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _obscure = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final UserRepository _userRepository = context.watch<UserRepository>();
    return Container(
      padding: EdgeInsets.all(5.0),
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
                  if (val.isEmpty) return "*Email is required";
                  return null;
                },
                controller: _email,
                textInputAction: TextInputAction.next,
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
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(passwordField);
                },
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
            //Login Button
            /*const SizedBox(
              height: 20.0,
            ),*/
            const SizedBox(
              height: 20.0,
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.4,
              child: MaterialButton(
                color: mainCol,
                textColor: bgCol,
                child: Text("Log in"),
                onPressed: () async {
                  Utils.hideKeyboard(textFieldFocus);
                  if (_formKey.currentState.validate()) {
                    // await _userRepository.signIn(_email.text, _password.text);
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
