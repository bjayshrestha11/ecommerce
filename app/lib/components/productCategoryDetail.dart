import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:app/components/shimmering/myshimmer.dart';
import 'package:app/components/ProductsByCategory.dart';
import 'package:app/constants/colors.dart';
import 'package:app/constants/icons.dart';
import 'package:app/models/category.dart';
import 'package:app/utilities/utils.dart';

class ProductCategoryDetail extends StatelessWidget {
  final Category category;
  ProductCategoryDetail({
    @required this.category,
  });
  @override
  Widget build(BuildContext context) {
    final double radius = 0;
    final double contHeight = 250;
    final CachedNetworkImage _cachedImage = CachedNetworkImage(
      imageUrl: category.imageUrl,
      placeholder: (_, url) {
        return MyShimmer.shimCont(72, width: 72);
      },
      alignment: Alignment.center,
      fit: BoxFit.scaleDown,
      errorWidget: (_, url, error) {
        return MyShimmer.shimCont(72, width: 72);
      },
    );

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: mainCol,
              pinned: true,
              floating: true,
              leading: IconButton(
                  icon: backIcon,
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              expandedHeight: contHeight,
              flexibleSpace: FlexibleSpaceBar(
                title: Text("${category.name}"),
                background: Container(
                  width: Utils.getWidthByPercentage(context, 100),
                  height: contHeight,
                  decoration: BoxDecoration(
                    color: black,
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
              ),
            ),
            SliverFillRemaining(
              child: ProductsByCategory(
                categoryId: category.id,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
