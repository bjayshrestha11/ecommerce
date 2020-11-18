import 'package:app/components/productBrandTile.dart';
import 'package:app/models/brand.dart';
import 'package:flutter/material.dart';
import 'package:app/components/productCategoryTile.dart';
import 'package:app/services/db_services.dart';

class AllBrands extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 10),
      child: StreamBuilder(
        stream: brandItemDb.streamList(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Brand>> snapshot) {
          if (snapshot.hasError)
            return Container(
              child: Center(
                child: Text("There was an error"),
              ),
            );
          if (snapshot.hasData) {
            var docList = snapshot.data;
            if (docList.isEmpty) {
              return Center(child: Text("No Brands Available"));
            }
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, i) {
                Brand brand = docList[i];
                return ProductBrandTile(
                  productBrand: brand,
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
