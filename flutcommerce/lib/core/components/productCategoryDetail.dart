import 'package:flutcommerce/core/components/productsByCategory.dart';
import 'package:flutcommerce/core/constants.dart';
import 'package:flutcommerce/models/category.model.dart';
import 'package:flutcommerce/utilities/utils.dart';
import 'package:flutter/material.dart';

class ProductCategoryDetail extends StatelessWidget {
  final Category category;
  ProductCategoryDetail({
    @required this.category,
  });
  @override
  Widget build(BuildContext context) {
    final double radius = 0;
    final double contHeight = 250;
    // final CachedNetworkImage _cachedImage = CachedNetworkImage(
    //   imageUrl: category.imageUrl,
    //   placeholder: (_, url) {
    //     return MyShimmer.shimCont(72, width: 72);
    //   },
    //   alignment: Alignment.center,
    //   fit: BoxFit.scaleDown,
    //   errorWidget: (_, url, error) {
    //     return MyShimmer.shimCont(72, width: 72);
    //   },
    // );

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
                    // child: _cachedImage,
                    child: Container(
                      child: Image.network(category.imageUrl),
                      height: 72,
                      width: 72,
                    ),
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
