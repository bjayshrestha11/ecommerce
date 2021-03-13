import 'package:flutcommerce/views/client/myAccount/profile/profile.dart';
import 'package:flutter/material.dart';

class MyAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Consumer(builder: (context, UserRepository userRepository, _) {
    //   switch (userRepository.status) {
    //     case Status.Uninitialized:
    //       return Splash();
    //     case Status.Unauthenticated:
    //     case Status.Authenticating:
    //       return Login();
    //     case Status.Authenticated: 
    //       return Profile();
    //     default:
    //       return Splash();
    //   }
    // });
    // return context.watch()<UserRepository>().status == Status.Authenticated ? Profile() : Login();
    return Profile();
  }
}