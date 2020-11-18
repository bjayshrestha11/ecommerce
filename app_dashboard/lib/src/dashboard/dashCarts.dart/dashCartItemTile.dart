import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodly_dashboard/components/shimmering/myshimmer.dart';
import 'package:foodly_dashboard/constants/colors.dart';
import 'package:foodly_dashboard/constants/strings.dart';
import 'package:foodly_dashboard/models/cartItem.dart';
import 'package:foodly_dashboard/utilities/utils.dart';

class DashCartItemTile extends StatelessWidget {
  final CartItem cartItem;
  // final String userId;
  final int index;
  DashCartItemTile({
    @required this.cartItem,
    @required this.index,
    // @required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final String imageUrl = cartItem.imageUrl;
    final int price = cartItem.price;
    final String name = cartItem.name;
    final int quantity = cartItem.quantity;

    final CachedNetworkImage _cachedImage = CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (_, url) {
        return MyShimmer.shimCont(72, width: 72);
      },
      alignment: Alignment.center,
      fit: BoxFit.cover,
      errorWidget: (_, url, error) {
        return MyShimmer.shimCont(72, width: 72);
      },
    );

    final double height = Utils.getHeightByPercentage(context, 8);

    return Container(
      margin: EdgeInsets.all(8),
      height: height,
      child: Row(
        children: [
          //photo
          Badge(
            badgeColor: secondCol,
            badgeContent: Text(
              "$quantity",
              style: TextStyle(color: mainCol, fontSize: 11),
            ),
            child: Container(
              height: height - 5,
              width: Utils.getWidthByPercentage(context, 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: _cachedImage,
            ),
          ),
          //name-quantity
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 8.0),
                  child: Text(
                    "$name",
                    style: TextStyle(fontSize: 14.0, color: secondCol),
                  ),
                ),
                //price,
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 8.0),
                  child: Text(
                    "$currency ${quantity*price}",
                    style: TextStyle(fontSize: 12.0, color: mainCol),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
