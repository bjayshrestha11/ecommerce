import 'package:flutter/material.dart';
import 'package:app/constants/colors.dart';
import 'package:app/constants/styles.dart';
import 'package:app/models/user.dart';
import 'package:app/resources/userRepository.dart';
import 'package:app/src/myAccount/profile/editProfile.dart';
import 'package:app/utilities/utils.dart';
import 'package:provider/provider.dart';

class UserDetail extends StatelessWidget {
  final String name;
  final String address;
  final int contact;
  UserDetail(
      {@required this.name, @required this.address, @required this.contact});
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: Utils.getHeightByPercentage(context, 16),
      padding: EdgeInsets.all(8),
      color: mainCol,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: Utils.getWidthByPercentage(context, 60),
            // padding: EdgeInsets.only(
            //   left: 10,
            // ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    name != null?"Name: $name":"Name: Not Set",
                    style: cartTextStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    address != null?"Address: $address":"Address: Not Set",
                    style: cartTextStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    contact != null?"Contact: $contact":"Contact: Not Set",
                    style: cartTextStyle,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 5),
            alignment: Alignment.topCenter,
            child: FlatButton(
              onPressed: () {
                Muser eUser = context.read<UserRepository>().getUser;
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return EditProfile(
                    eUser: eUser,
                    // mode: 0,
                  );
                }));
              },
              child: Text(
                "Edit",
                style: TextStyle(color: secondCol),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
