import 'package:flutcommerce/utilities/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashTile extends StatelessWidget {
  final String routeName;
  final IconData icon;
  final String name;
  final Color color;
  final Color bgCol;
  DashTile({@required this.routeName, this.icon, this.name, this.color, this.bgCol});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).pushNamed(routeName);
        Get.toNamed(routeName);
      },
      child: Card(
        elevation: 10,
        shadowColor: Colors.grey,
        margin: EdgeInsets.all(5),
        child: Container(
          width: Utils.getWidthByPercentage(context, 40),
          height: Utils.getHeightByPercentage(context, 15),
          color: color,
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