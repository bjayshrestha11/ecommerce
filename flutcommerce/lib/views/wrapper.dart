
import 'package:flutcommerce/helpers/firebaseAuth.controller.dart';
import 'package:flutcommerce/views/auth/login.view.dart';
import 'package:flutcommerce/views/home/home.view.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class Wrapper extends GetWidget<FirebaseAuthController> {
  @override
  Widget build(BuildContext context) {
    return Obx((){
       return Get.find<FirebaseAuthController>().user!=null ? HomeWidget() : LoginWidget();
    });
  }
}