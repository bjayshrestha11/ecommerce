import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:foodly_dashboard/components/cachedImage/cachedImage.dart';
import 'package:foodly_dashboard/constants/colors.dart';
import 'package:foodly_dashboard/models/order.dart';
import 'package:foodly_dashboard/utilities/utils.dart';

class DashOrderItemTile extends StatelessWidget {
  final OrderedItem orderedItem;
  DashOrderItemTile(this.orderedItem);
  @override
  Widget build(BuildContext context) {
    final double width = Utils.getWidthByPercentage(context, 23);
    return Container(
      width: width,
      margin: EdgeInsets.all(15.0),
      // height: 100,
      color: Colors.grey[200],
      child: Column(
        children: [
          //Image
          Badge(
            badgeContent: Text("${orderedItem.quantity}"),
            child: SizedBox(
              width: width,
              height: width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedImage(
                  orderedItem.imageUrl,
                  fit: BoxFit.cover,
                  isRound: false,
                  width: width,
                  height: width,
                ),
              ),
            ),
          ),
          //name with count
          Text(
            "${orderedItem.name}",
            style: TextStyle(
              color: secondCol,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }
}
