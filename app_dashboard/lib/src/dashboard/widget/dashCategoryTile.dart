import 'package:flutter/material.dart';
import 'package:foodly_dashboard/components/cachedImage/cachedImage.dart';
import 'package:foodly_dashboard/constants/colors.dart';
import 'package:foodly_dashboard/models/category.dart';
import 'package:foodly_dashboard/utilities/utils.dart';

class DashCategoryTile extends StatelessWidget {
  final Category category;
  DashCategoryTile({@required this.category});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () {
      //   Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      //     return ProductCategoryDetail(category: productCategory);
      //   }));
      // },
      child: Container(
        width: Utils.getWidthByPercentage(context, 23),
        margin: EdgeInsets.all(15.0),
        height: 100,
        color: Colors.grey[200],
        child: Column(
          children: [
            //Image
            SizedBox(
              width: 72,
              height: 72,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedImage(
                  category.imageUrl,
                  fit: BoxFit.cover,
                  isRound: false,
                  width: 72,
                  height: 72,
                ),
              ),
            ),
            //name with count
            Text(
              "${Utils.getFirstInitials(category.name)}",
              style: TextStyle(
                color: secondCol,
                fontSize: 12.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}