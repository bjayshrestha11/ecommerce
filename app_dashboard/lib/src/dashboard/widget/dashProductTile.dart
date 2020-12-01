import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:app_dashboard/components/shimmering/myshimmer.dart';
import 'package:app_dashboard/constants/colors.dart';
import 'package:app_dashboard/constants/strings.dart';
import 'package:app_dashboard/models/product.dart';
import 'package:app_dashboard/src/dashboard/widget/dashProductDetail.dart';
import 'package:app_dashboard/utilities/utils.dart';
class DashProductTile extends StatelessWidget {
  final Product product;
  DashProductTile({
    @required this.product,
  });
  
  @override
  Widget build(BuildContext context) {
    final double wFC = Utils.getWidthByPercentage(context, 30);
    final double wSC = Utils.getWidthByPercentage(context, 60);
    final double hPT = 110.0;

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

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return DashProductDetail(
            product: product,
          );
        }));
      },
      child: Container(
        color: bgCol,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Image
            Container(
              height: hPT,
              width: wFC,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: _cachedImage,
            ),
            //Name, Description and Price
            Container(
              width: wSC,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Text(
                      "${product.name}",
                      style: TextStyle(fontSize: 19.0, color: secondCol),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                    child: Text(
                      "$currency${product.salePrice}",
                      style: TextStyle(fontSize: 16.0, color: mainCol),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
