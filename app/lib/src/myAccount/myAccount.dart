import 'package:flutter/material.dart';
import 'package:app/components/splash.dart';
import 'package:app/enums/authState.dart';
import 'package:app/resources/userRepository.dart';
import 'package:app/src/myAccount/auth/auth.dart';
import 'package:app/src/myAccount/profile/profile.dart';
import 'package:provider/provider.dart';

class MyAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, UserRepository userRepository, _) {
      switch (userRepository.status) {
        case Status.Uninitialized:
          return Splash();
        case Status.Unauthenticated:
        case Status.Authenticating:
          return Login();
        case Status.Authenticated: 
          return Profile();
        default:
          return Splash();
      }
    });
    // return context.watch()<UserRepository>().status == Status.Authenticated ? Profile() : Login();
  }
}