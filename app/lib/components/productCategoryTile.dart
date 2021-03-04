import 'package:flutter/material.dart';
import 'package:app/components/cachedImage/cachedImage.dart';
import 'package:app/components/productCategoryDetail.dart';
import 'package:app/models/category.dart';
import 'package:app/utilities/utils.dart';

class ProductCategoryTile extends StatelessWidget {
  final Category productCategory;
  ProductCategoryTile({
    this.productCategory,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return ProductCategoryDetail(category: productCategory);
        }));
      },
      child: Container(
        padding: EdgeInsets.only(right: 3.0),
        width: MediaQuery.of(context).size.width * 0.23,
        height: MediaQuery.of(context).size.height * 0.07,
        //color: mainCol,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            width: 0.6,
            color: Theme.of(context).backgroundColor,
          ),
          // color: bgCol,
          boxShadow: [
            BoxShadow(
              // color: secondCol.withOpacity(0.08),
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(2, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            //Image
            SizedBox(
              width: 100,
              height: 78,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: CachedImage(
                    productCategory.imageUrl,
                    fit: BoxFit.cover,
                    isRound: false,
                    height: 70.0,
                    width: 70.0,
                  ),
                ),
              ),
            ),
            //name with count
            SizedBox(
              height: 4.0,
            ),
            Text(
              "${Utils.getFirstInitials(productCategory.name)}",
              style: TextStyle(
                // color: secondCol,
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
