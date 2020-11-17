import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:app/components/productDetails.dart';
import 'package:app/components/shimmering/myshimmer.dart';
import 'package:app/constants/colors.dart';
import 'package:app/constants/icons.dart';
import 'package:app/constants/strings.dart';
import 'package:app/models/product.dart';
import 'package:app/providers/cartProvider.dart';
import 'package:app/sharedPrefs/preferences.dart';
import 'package:app/utilities/utils.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../constants/icons.dart';

class ProductTile extends StatefulWidget {
  final Product product;
  ProductTile({
    @required this.product,
  });

  @override
  _ProductTileState createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  String _userID;

  getUserId() async {
    _userID = await Prefs.getuserId();
    setState(() {});
  }

  @override
  void initState() {
    getUserId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double wFC = Utils.getWidthByPercentage(context, 30);
    final double wSC = Utils.getWidthByPercentage(context, 52);
    final double wTC = Utils.getWidthByPercentage(context, 10);
    final double hPT = 90.0;

    final CachedNetworkImage _cachedImage = CachedNetworkImage(
      imageUrl: widget.product.imageUrl,
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
          return ProductDetail(
            wooProduct: widget.product,
          );
        }));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 9.0),
        child: Container(
          decoration: BoxDecoration(
            color: bgCol,
            boxShadow: [
              BoxShadow(
                color: mainCol.withOpacity(0.06),
                spreadRadius: 5,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Image

              Container(
                height: hPT,
                width: wFC,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5)),
                  child: _cachedImage,
                ),
              ),
              //Name, Description and Price
              Container(
                width: wSC,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 7.0),
                      child: Text(
                        "${widget.product.name}",
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                            color: secondCol),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 5.0),
                      child: Text(
                        "$currency${widget.product.salePrice}",
                        style: TextStyle(
                            fontSize: 14.0,
                            color: mainCol,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              //Add to cart button
              Container(
                decoration: BoxDecoration(
                  color: secondCol,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5)),
                ),
                width: wTC,
                height: hPT,
                child: Center(
                  child: IconButton(
                    icon: add_to_cart,
                    onPressed: () {
                      context
                          .read<CartProvider>()
                          .addToCart(widget.product, _userID);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
