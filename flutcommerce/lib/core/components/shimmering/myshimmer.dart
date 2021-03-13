import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';

class MyShimmer {
  static Widget userCircle(double radius) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      enabled: true,
      child: Container(
        height: radius,
        width: radius,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: SizedBox(
          height: radius,
          width: radius,
        ),
      ),
    );
  }

  static Widget appTitle() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      enabled: true,
      child: Text("Master List",
          style: TextStyle(
            color: Colors.white,
          )),
    );
  }

  static Widget shimCont(double height, {double width}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      enabled: true,
      child: Container(
        width: width,
        height: height,
        color: Colors.white,
      ),
    );
  }

  static Widget shimIcon(IconData icon) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      enabled: true,
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }

  static Widget shimMasterTile() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      enabled: true,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 4.0,
          horizontal: 8.0,
        ),
        child: ListTile(
          trailing: userCircle(35.0),
          title: shimCont(40),
        ),
      ),
    );
  }

  static Widget shimDivider({double height, double thickness}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      enabled: true,
      child: Divider(
        thickness: thickness,
        height: height,
        color: Colors.white,
      ),
    );
  }

  static Widget shimText(String text, double fontSize) {
    return Shimmer.fromColors(
      baseColor: Colors.red[300],
      highlightColor: Colors.orange[100],
      enabled: true,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
        ),
      ),
    );
  }

  static Widget shimPersonalTile() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      enabled: true,
      child: ListTile(
        leading: Icon(
          FontAwesomeIcons.arrowRight,
          color: Colors.white,
        ),
        title: shimCont(25),
      ),
    );
  }

  static Widget shimChatTile() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      enabled: true,
      child: ListTile(
        leading: userCircle(50),
        title: shimCont(50),
      ),
    );
  }

  static Widget shimFamUserTile() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      enabled: true,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        child: Column(
          children: [
            userCircle(50),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: shimCont(10, width: 30),
            )
          ],
        ),
      ),
    );
  }
}