import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:app_dashboard/components/shimmering/myshimmer.dart';
import 'package:app_dashboard/constants/colors.dart';
import 'package:app_dashboard/constants/strings.dart';
import 'package:app_dashboard/models/product.dart';
import 'package:app_dashboard/utilities/utils.dart';

class DashProductDetail extends StatelessWidget {
  final Product product;
  DashProductDetail({
    @required this.product,
  });

  @override
  Widget build(BuildContext context) {
    // final int productId = widget.wooProduct.id;

    final double radius = 30;
    final double contHeight = 250;
    final CachedNetworkImage _cachedImage = CachedNetworkImage(
      imageUrl: product.imageUrl,
      placeholder: (_, url) {
        return MyShimmer.shimCont(72, width: 72);
      },
      alignment: Alignment.center,
      fit: BoxFit.cover,
      errorWidget: (_, url, error) {
        return MyShimmer.shimCont(72, width: 72);
      },
    );

    final String description = product.description;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Image
          Container(
            width: Utils.getWidthByPercentage(context, 100),
            height: contHeight,
            decoration: BoxDecoration(
              color: mainCol,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(radius),
                bottomRight: Radius.circular(radius),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(radius),
                bottomRight: Radius.circular(radius),
              ),
              child: _cachedImage,
            ),
          ),
          //Product name
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 10),
            child: Center(
              child: Text(
                "${product.name}",
                style: TextStyle(fontSize: 28.0, color: mainCol),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Utils.getDivider(),
          //Category Id
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Category Id:",
                    style: TextStyle(color: secondCol, fontSize: 19),
                  ),
                  TextSpan(
                    text: "\t\t#${product.categoryId} ",
                    style: TextStyle(
                      color: thirdCol,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Utils.getDivider(),

          //Description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: Text(
              "Description:",
              style: TextStyle(color: secondCol, fontSize: 19),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 36.0, right: 8.0),
            child: Text(
              "$description",
              style: TextStyle(fontSize: 11.0, color: thirdCol),
            ),
          ),
          Utils.getDivider(),
          //Price
          Container(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 36),
                  child: Text(
                    "Price:",
                    style: TextStyle(color: secondCol, fontSize: 19),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        product.regularPrice.toString() != ""
                            ? TextSpan(
                                text: "$currency${product.regularPrice} ",
                                style: TextStyle(
                                    color: thirdCol,
                                    fontSize: 16,
                                    decoration: TextDecoration.lineThrough),
                              )
                            : TextSpan(),
                        product.salePrice.toString() != ""
                            ? TextSpan(
                                text: " $currency${product.salePrice}",
                                style: TextStyle(color: mainCol, fontSize: 16),
                              )
                            : TextSpan(
                                text: " $currency free",
                                style: TextStyle(color: mainCol, fontSize: 16),
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Utils.getDivider(),
          //back
          Container(
            child: Center(
              child: FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Back",
                  style: TextStyle(
                      color: mainCol, decoration: TextDecoration.underline),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
