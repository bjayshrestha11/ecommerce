import 'package:flutcommerce/core/components/quietBox.dart';
import 'package:flutcommerce/core/constants.dart';
import 'package:flutcommerce/helpers/firebaseDb.dart';
import 'package:flutcommerce/models/product.model.dart';
import 'package:flutcommerce/utilities/utils.dart';
import 'package:flutcommerce/views/admin/widgets/dashProductTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: backIcon,
            onPressed: () {
              // Navigator.pop(context);
              Get.back();
            }),
        title: RichText(
          text: TextSpan(
            style: TextStyle(color: black, fontSize: 26.0),
            children: <TextSpan>[
              TextSpan(text: "All "),
              TextSpan(text: "Products", style: TextStyle(color: mainCol)),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //all products
                    Flexible(
                      child: Container(
                        height: Utils.getHeightByPercentage(context, 76),
                        color: bgCol,
                        child: StreamBuilder(
                          stream: productItemDb.streamList(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Product>> snapshot) {
                            if (snapshot.hasError)
                              return QuietBox(
                                imgPath: "assets/images/error.png",
                                text: "Oops Something went wrong.", 
                              );
                            if (snapshot.hasData) {
                              var docList = snapshot.data;
                              if (docList.isEmpty) {
                                return QuietBox(
                                imgPath: "assets/images/empty_state.png",
                                text: "No Product Found.", 
                              );
                              }
                              return ListView.separated(
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
                                  return DashProductTile(product: product);
                                },
                              );
                            }
                            return Center(
                              child: Text("..."),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: mainCol,
      //   child: addIcon,
      //   onPressed: () {
      //     Navigator.of(context).push(MaterialPageRoute(builder: (_){
      //       return AddProduct();
      //     }));
      //   },
      // ),
    );
  }
}
