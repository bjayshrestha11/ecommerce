import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:app_dashboard/constants/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as Im;
import 'package:path_provider/path_provider.dart';
import 'package:meta/meta.dart';

class Utils {

  static showKeyboard(textFieldFocus) => textFieldFocus.requestFocus();

  static hideKeyboard(textFieldFocus) => textFieldFocus.unfocus();

  static showToast(String msg) {
    return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: toastCol,
    );
  }

  static Future<bool> confirmBox(
      BuildContext context, String title, String content) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: Text(title),
              content: Text(content),
              actions: <Widget>[
                FlatButton(
                  child: Text("No"),
                  onPressed: () => Navigator.pop(context, false),
                ),
                FlatButton(
                  child: Text("Yes"),
                  onPressed: () => Navigator.pop(context, true),
                ),
              ],
            ));
  }

  static double getWidthByPercentage(BuildContext context, double percent) {
    Size size = MediaQuery.of(context).size;
    return (percent / 100) * size.width;
  }

  static double getHeightByPercentage(BuildContext context, double percent) {
    Size size = MediaQuery.of(context).size;
    return (percent / 100) * size.height;
  }

  static String getInitials(String name) {
    if (name != null) {
      List<String> nameSplit = name.split(" ");
      String firstNameInitial = nameSplit[0][0];
      String lastNameInitial = nameSplit[1][0];
      return firstNameInitial + lastNameInitial;
    } else {
      return "NS";
    }
  }

  static String getFirstInitials(String string) {
    List<String> stringSplit = string.split(" ");
    String firstInitials = stringSplit[0];
    return firstInitials;
  }

  static String getNInitials(String string, int n) {
    List<String> stringSplit = string.split(" ");
    // String fiveInitials = "${stringSplit[0]} ${stringSplit[1]} ${stringSplit[2]} ${stringSplit[3]} ${stringSplit[4]} ${stringSplit[5]}";
    String result = "";
    for (int i = 0; i <= n; i++) {
      result += " ${stringSplit[i]}";
    }
    return result;
  }

  static int strToInt(String str) {
    return int.parse(str);
  }


  static Future<File> pickImage({@required ImageSource source}) async {
    File selectedImage = await ImagePicker.pickImage(source: source);
    if (selectedImage != null)
      return await compressImage(selectedImage);
    else
      return null;
  }

  static Future<File> compressImage(File imageToCompress) async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    int rand = Random().nextInt(10000);

    Im.Image image = Im.decodeImage(imageToCompress.readAsBytesSync());
    Im.copyResize(image, width: 500, height: 500);

    return new File('$path/img_$rand.jpg')
      ..writeAsBytesSync(Im.encodeJpg(image, quality: 85));
  }

  static Widget getDivider() {
    return Divider(
      color: thirdCol,
      thickness: 1,
      indent: 30,
      endIndent: 30,
    );
  }
}
