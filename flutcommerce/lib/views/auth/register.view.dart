
import 'package:flutcommerce/helpers/firebaseAuth.controller.dart';
import 'package:flutcommerce/views/auth/login.view.dart';
import 'package:flutcommerce/views/auth/widget/socialSignWidgetRow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class RegistrationWidget extends GetWidget<FirebaseAuthController> {
  final TextEditingController firstn = TextEditingController();
  final TextEditingController lastn = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/backgroundUI.png"),
                        fit: BoxFit.cover)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 100,
                          width: 100,
                          child: SvgPicture.asset("assets/images/xing.svg")),
                      SizedBox(height: 10),
                      Text("Registration"),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: TextField(
                          controller: firstn,
                          decoration: InputDecoration(
                            hintText: 'First Name',
                            hintStyle: TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                                borderSide:
                                    BorderSide(color: Colors.blue[400])),
                            isDense: true, // Added this
                            contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                          ),
                          cursorColor: Colors.white,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: TextField(
                          controller: lastn,
                          decoration: InputDecoration(
                            hintText: 'Last Name',
                            hintStyle: TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                                borderSide:
                                    BorderSide(color: Colors.blue[400])),
                            isDense: true, // Added this
                            contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                          ),
                          cursorColor: Colors.white,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: TextField(
                          controller: email,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                                borderSide:
                                    BorderSide(color: Colors.blue[400])),
                            isDense: true, // Added this
                            contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                          ),
                          cursorColor: Colors.white,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: TextField(
                          controller: password,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                                borderSide:
                                    BorderSide(color: Colors.blue[400])),
                            isDense: true, // Added this
                            contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                          ),
                          cursorColor: Colors.white,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          // final close = context.showLoading(msg: "Loading");
                          // Future.delayed(4.seconds, close); // Removes toast after 2 seconds
                          registerUser();
                        },
                        child: Text("Sign-Up"),
                      ),
                       SizedBox(height:140),
                      Text("Login with"),
                      SocialSignWidgetRow()
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => LoginWidget()));
          },
          child: RichText(
              text: TextSpan(
            text: 'New User?',
            style: TextStyle(fontSize: 15.0, color: Colors.black),
            children: <TextSpan>[
              TextSpan(
                text: ' Login Now',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Color(0XFF4321F5)),
              ),
            ],
          )),
        ));
  }

  void registerUser() {
    controller.createUser(firstn.text, lastn.text, email.text, password.text);
  }
}
