
import 'package:flutcommerce/helpers/firebaseAuth.controller.dart';
import 'package:flutcommerce/views/auth/forgotPassword.view.dart';
import 'package:flutcommerce/views/auth/register.view.dart';
import 'package:flutcommerce/views/auth/widget/socialSignWidgetRow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoginWidget extends GetWidget<FirebaseAuthController> {

  final TextEditingController email = TextEditingController();
  final TextEditingController pass = TextEditingController();
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
                        fit: BoxFit.cover
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20,40 , 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: 100,
                        width: 100,
                        child: SvgPicture.asset("assets/images/xing.svg")),
                     SizedBox(height:10),
                    Text("Login"),
                     SizedBox(height:20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: TextField(
                        controller: email,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.white
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.blue[400]
                            )
                          ),
                          isDense: true,                      // Added this
                          contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                        ),
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                SizedBox(height:20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: TextField(
                        controller: pass,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                                color: Colors.white
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                  color: Colors.blue[400]
                              )
                          ),
                          isDense: true,                      // Added this
                          contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                        ),
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                     SizedBox(height:20),

                    GestureDetector(onTap: (){
                      Get.to(ForgotPassword());
                    },
                    child: Text("Forgot Password ? Reset Now",style: TextStyle(color: Colors.white),),),

                     SizedBox(height:10),
                    GestureDetector(
                        onTap: (){
                          print("Login Clicked Event");
                          _login();
                        },
                        child: Text("Login"),),
                    SizedBox(height:20),
                    Text("Login with"),
                    SocialSignWidgetRow()

                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: GestureDetector(
          onTap: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RegistrationWidget()));
          },
          child: RichText(text: TextSpan(
            text: 'New User?',
            style: TextStyle(fontSize: 15.0, color: Colors.black),
            children: <TextSpan>[
              TextSpan(
                text: ' Register Now',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Color(0XFF4321F5)),
              ),
            ],
          )
          ),
        )
    );
  }

  void _login() {
    controller.login(email.text, pass.text);
  }

}