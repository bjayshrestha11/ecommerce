import 'package:flutcommerce/utilities/utils.dart';
import 'package:flutter/material.dart';

class QuietBox extends StatelessWidget {
  final String imgPath;
  final String text;
  final String routeName;
  final String btnText;
  QuietBox({this.imgPath, this.text, this.btnText, this.routeName});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //image
            Container(
              width: Utils.getWidthByPercentage(context, 60),
              height: Utils.getHeightByPercentage(context, 40),
              child: imgPath != null
                  ? Image.asset(imgPath)
                  : Image.asset("assets/images/empty_state.png"),
            ),
            //text
            text != null ? Text(text) : Text("Ooops Nothing Found"),
            //button
            btnText != null ? ElevatedButton(
              child: Text(btnText),
              onPressed: () {
                Navigator.of(context).pushNamed(routeName);
              },
            ):Container(),
          ],
        ),
      ),
    );
  }
}
