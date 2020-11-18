import 'package:flutter/material.dart';
import 'package:foodly_dashboard/constants/colors.dart';
import 'package:foodly_dashboard/utilities/utils.dart';

class DashTile extends StatelessWidget {
  final String routeName;
  final IconData icon;
  final String name;
  DashTile({@required this.routeName, this.icon, this.name});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(routeName);
      },
      child: Card(
        elevation: 10,
        shadowColor: secondCol,
        margin: EdgeInsets.all(5),
        child: Container(
          width: Utils.getWidthByPercentage(context, 40),
          height: Utils.getHeightByPercentage(context, 15),
          color: mainCol,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Icon
              Icon(
                icon,
                color: bgCol,
              ),
              //Name
              Text(
                "$name",
                style: TextStyle(color: bgCol),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
