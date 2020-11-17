import 'package:flutter/material.dart';
import 'package:app/components/cachedImage/cachedImage.dart';
import 'package:app/components/shimmering/myshimmer.dart';
import 'package:app/constants/colors.dart';
import 'package:app/constants/icons.dart';
import 'package:app/sharedPrefs/preferences.dart';

class UserCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
        child: FutureBuilder(
          future: Prefs.getProfilePhoto(),
          builder: (_, AsyncSnapshot<String> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
                return MyShimmer.userCircle(40);
                break;
              case ConnectionState.done:
                return snapshot.data != null
                    ? CachedImage(
                        snapshot.data,
                        isRound: true,
                        radius: 50,
                      )
                    : Icon(profileIcon);
                break;
              default:
                return Icon(profileIcon);
            }
          },
        ),
      ),
    );
  }
}
