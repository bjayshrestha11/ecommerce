import 'package:flutter/material.dart';
import 'package:app/components/productCategoryTile.dart';
import 'package:app/models/category.dart';
import 'package:app/services/db_services.dart';

class AllCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 10),
      child: StreamBuilder(
        stream: categoryItemDb.streamList(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
          if (snapshot.hasError)
            return Container(
              child: Center(
                child: Text("There was an error"),
              ),
            );
          if (snapshot.hasData) {
            var docList = snapshot.data;
            if (docList.isEmpty) {
              return Center(child: Text("No Categories Available"));
            }
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, i) {
                Category category = docList[i];
                return ProductCategoryTile(
                  productCategory: category,
                );
              },
              separatorBuilder: (_, i) {
                return SizedBox(
                    width: 1.0,
                  );
              },
              itemCount: docList.length,
            );
          }
          return Center(
            child: Text("..."),
          );
        },
      ),
    );
  }
}
