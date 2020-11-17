import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/components/productTile.dart';
import 'package:app/models/product.dart';
import 'package:app/services/db_services.dart';

class AllProducts extends StatefulWidget {
  @override
  _AllProductsState createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: StreamBuilder(
        stream: productItemDb.streamList(),
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
              return Center(child: Text("No Products Available"));
            }
            return ListView.separated(
              controller: _scrollController,
              separatorBuilder: (_, i) {
                return SizedBox(
                  height: 5.0,
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
