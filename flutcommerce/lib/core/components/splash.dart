import 'package:flutcommerce/core/components/shimmering/myshimmer.dart';
import 'package:flutter/material.dart';
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