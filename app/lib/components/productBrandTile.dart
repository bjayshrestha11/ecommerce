import 'package:app/models/brand.dart';
import 'package:flutter/material.dart';
import 'package:app/components/cachedImage/cachedImage.dart';
import 'package:app/constants/colors.dart';
import 'package:app/utilities/utils.dart';

import '../constants/colors.dart';

class ProductBrandTile extends StatelessWidget {
  final Brand productBrand;
  ProductBrandTile({
    this.productBrand,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () {
      //   Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      //     return ProductCategoryDetail(category: productCategory);
      //   }));
      // },
      child: Padding(
        padding: const EdgeInsets.only(right: 0.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.23,
          height: MediaQuery.of(context).size.height * 0.07,
          //color: mainCol,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(width: 0.6, color: mainCol),
            color: bgCol,
            boxShadow: [
              BoxShadow(
                color: secondCol.withOpacity(0.08),
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
                      productBrand.imageUrl,
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
                "${Utils.getFirstInitials(productBrand.brandName)}",
                style: TextStyle(
                  color: secondCol,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
