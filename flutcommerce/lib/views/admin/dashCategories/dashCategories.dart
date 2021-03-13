import 'package:flutcommerce/core/components/quietBox.dart';
import 'package:flutcommerce/core/constants.dart';
import 'package:flutcommerce/helpers/firebaseDb.dart';
import 'package:flutcommerce/models/category.model.dart';
import 'package:flutcommerce/utilities/utils.dart';
import 'package:flutcommerce/views/admin/widgets/dashCategoryTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashCategories extends StatelessWidget {
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
              TextSpan(text: "Categories", style: TextStyle(color: mainCol)),
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
                          stream: categoryItemDb.streamList(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Category>> snapshot) {
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
                                  text: "No Categories Found.",
                                );
                              }
                              return Wrap(
                                alignment: WrapAlignment.spaceEvenly,
                                children: docList.map((category) {
                                  return DashCategoryTile(
                                    category: category,
                                  );
                                }).toList(),
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
      //     Utils.showToast("Add Category");
      //   },
      // ),
    );
  }
}
