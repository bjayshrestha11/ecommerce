import 'package:flutcommerce/helpers/firebaseAuth.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SocialSignWidgetRow extends GetWidget<FirebaseAuthController> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [

        GestureDetector(
          onTap: (){
            print("Google Clicked");
            controller.googleLogIn();
          },
          child: Container(
            width: 30,
            height: 30,
            child: SvgPicture.asset("assets/images/google.svg"),
          ),
        ),
        GestureDetector(
          onTap: (){
            print("Facebook Clicked");

            controller.fbLogin();
          },
          child: Container(
            width: 30,
            height: 30,
            child: SvgPicture.asset("assets/images/facebook.svg"),
          ),
        ),
      ],
    );
  }
}