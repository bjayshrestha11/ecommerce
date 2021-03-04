import 'package:app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:app/components/appbar.dart';
import 'package:app/components/cachedImage/cachedImage.dart';
import 'package:app/constants/colors.dart';
import 'package:app/constants/icons.dart';
import 'package:app/constants/styles.dart';
import 'package:app/models/user.dart';
import 'package:app/resources/userRepository.dart';
import 'package:app/src/myAccount/profile/userDetail.dart';
import 'package:app/src/myAccount/profile/editProfile.dart';
import 'package:app/utilities/utils.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.watch<UserRepository>().refreshUser();
    String name = context.watch<UserRepository>().getUser.name;
    String address = context.watch<UserRepository>().getUser.address;
    int contact = context.watch<UserRepository>().getUser.phoneNumber;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: backIcon,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Profile",
          // style: appTitleStyle,
        ),
        centerTitle: true,
      ),
      // backgroundColor: bgCol,
      body: Container(
        margin: EdgeInsets.only(top: 25),
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                children: [
                  context.watch<UserRepository>().getUser.profilePhoto != null
                      ? Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: CachedImage(
                                  context
                                      .watch<UserRepository>()
                                      .getUser
                                      .profilePhoto,
                                  isRound: true,
                                  radius: 100.0 - 2.0,
                                ),
                              ),
                              Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    // padding: EdgeInsets.only(left: 30.0),
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    child: IconButton(
                                        icon: Icon(Icons.edit),
                                        tooltip: "CHANGE PROFILE",
                                        iconSize: 20,
                                        color:
                                            Theme.of(context).backgroundColor,
                                        onPressed: () {
                                          Muser eUser = context
                                              .read<UserRepository>()
                                              .getUser;
                                          Navigator.of(context).push(
                                              MaterialPageRoute(builder: (_) {
                                            return EditProfile(
                                              eUser: eUser,
                                              // mode: 0,
                                            );
                                          }));
                                        }),
                                  )),
                            ],
                          ),
                        )
                      : Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: buttonCol,
                          ),
                          child: Center(
                            child: Text(
                              Utils.getInitials(
                                  context.watch<UserRepository>().getUser.name),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                // color: UniversalVariables.lightBlueColor,
                                fontSize: 20,
                              ),
                            ),
                          )),
                  SizedBox(height: 15),
                  UserDetail(
                    name: name,
                    address: address,
                    contact: contact,
                  ),
                  SizedBox(height: 15),
                  ListTile(
                    tileColor: Theme.of(context).primaryColor,
                    title: Text(
                      "Edit Profile",
                    ),
                    onTap: () async {
                      Muser eUser = context.read<UserRepository>().getUser;
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) {
                        return EditProfile(
                          eUser: eUser,
                          // mode: 0,
                        );
                      }));
                    },
                  ),
                  SizedBox(height: 15),
                  SwitchListTile(
                    tileColor: Theme.of(context).primaryColor,
                    title: Text("Dark Mode"),
                    onChanged: (val) {
                      context.read<ThemeNotifier>().toggleTheme();
                    },
                    value: context.watch<ThemeNotifier>().darkTheme,
                  ),
                  SizedBox(
                    height: 60.0,
                  ),
                  ListTile(
                    tileColor: Theme.of(context).primaryColor,
                    leading: IconButton(
                      tooltip: "LOG OUT",
                      icon: Icon(
                        LOGOUT_ICON,
                        // color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () async {
                        if (await Utils.confirmBox(context, "Log Out",
                            "Do you really want to log out?")) {
                          await context.read<UserRepository>().signOut();
                        }
                      },
                    ),
                    title: Text(
                      "Log Out",
                      // style: TextStyle(
                      //   color: Theme.of(context).primaryColor,
                      // ),
                    ),
                    // contentPadding: EdgeInsets.only(left: 70.0),
                    onTap: () async {
                      if (await Utils.confirmBox(context, "Log Out",
                          "Do you really want to log out?")) {
                        await context.read<UserRepository>().signOut();
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
