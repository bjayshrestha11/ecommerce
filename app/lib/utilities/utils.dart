import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:app/components/appbar.dart';
import 'package:app/constants/colors.dart';
import 'package:app/constants/icons.dart';
import 'package:app/sharedPrefs/preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as Im;
import 'package:path_provider/path_provider.dart';
import 'package:meta/meta.dart';

// import 'package:app/streams/cartstream.dart';
import 'package:share/share.dart';
// import 'package:woocommerce/models/products.dart';

class Utils {
  //to derive username from email address
  static String getUsername(String email) {
    return "${email.split('@')[0]}";
  }

  //
  static share(BuildContext context, String text, String subject) {
    final RenderBox box = context.findRenderObject();
    Share.share(text,
        subject: subject,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

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

  static CustomAppBar customAppBar(context) => CustomAppBar(
        leading: Container(
          decoration: BoxDecoration(
            color: mainCol,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: leadAppIcon,
            onPressed: () {
              Navigator.of(context).pushNamed("/test");
            },
          ),
        ),
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(
              color: thirdCol,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: locationIcon,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Ramechhap",
                      style: TextStyle(color: mainCol, fontSize: 16.0),
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 8.0),
                child: downArrowIcon,
              ),
            ],
          ),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed("/myAccount");
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: mainCol,
                shape: BoxShape.circle,
              ),
            ),
          )
        ],
      );

  static int strToInt(String str) {
    return int.parse(str);
  }

  static String getLastName(String name) {
    try {
      List<String> nameSplit = name.split(" ");
      String lastName = nameSplit[1];
      return lastName;
    } catch (e) {
      return "";
    }
  }

  static String getFirstName(String name) {
    try {
      List<String> nameSplit = name.split(" ");
      String firstName = nameSplit[0];
      return firstName;
    } catch (e) {
      return "";
    }
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

  static saveToPrefereces(
      {String name,
      String photo,
      String userId,
      String email,
      int phoneNumber,
      String address}) {
    Prefs.saveName(name);
    Prefs.saveProfilePhoto(photo);
    Prefs.saveUserId(userId);
    Prefs.saveUserEmail(email);
    Prefs.saveUserPhoneNumber(phoneNumber);
    Prefs.saveUserAddress(address);
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
