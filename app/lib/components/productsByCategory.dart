import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/components/productTile.dart';
import 'package:app/components/quietBox.dart';
import 'package:app/constants/colors.dart';
import 'package:app/models/product.dart';
import 'package:app/services/db_services.dart';

class ProductsByCategory extends StatelessWidget {
  final String categoryId;

  ProductsByCategory({
    @required this.categoryId,
  });
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: StreamBuilder(
        stream: productItemDb.streamListByCategoryId(categoryId),
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
          if (snapshot.hasError)
            return Container(
              child: Center(
                child: Text("There was an error"),
              ),
            );
          if (snapshot.hasData) {
            var docList = snapshot.data;
            if (docList.isEmpty) {
              return QuietBox(
                text: "No Products Available",
              );
            }
            return ListView.separated(
              controller: _scrollController,
              separatorBuilder: (_, i) {
                return i.isEven
                    ? Divider(
                        color: mainCol,
                      )
                    : Divider(
                        color: secondCol,
                      );
              },
              itemCount: docList.length,
              itemBuilder: (_, i) {
                Product product = docList[i];
                return ProductTile(product: product);
              },
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
