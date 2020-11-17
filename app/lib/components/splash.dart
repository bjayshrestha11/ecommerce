import 'package:flutter/material.dart';
import 'package:app/components/shimmering/myshimmer.dart';
class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: MyShimmer.shimText(". . .",50.0),
        ),
      ),
    );
  }
}