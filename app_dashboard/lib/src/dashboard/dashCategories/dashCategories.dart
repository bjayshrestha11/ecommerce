import 'package:flutter/material.dart';
import 'package:foodly_dashboard/components/appbar.dart';
import 'package:foodly_dashboard/components/quietBox.dart';
import 'package:foodly_dashboard/constants/colors.dart';
import 'package:foodly_dashboard/constants/icons.dart';
import 'package:foodly_dashboard/models/category.dart';
import 'package:foodly_dashboard/services/db_services.dart';
import 'package:foodly_dashboard/src/dashboard/widget/dashCategoryTile.dart';
import 'package:foodly_dashboard/utilities/utils.dart';

class DashCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppBar(
                      leading: IconButton(
                          icon: backIcon,
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      title: RichText(
                        text: TextSpan(
                          style: TextStyle(color: black, fontSize: 26.0),
                          children: <TextSpan>[
                            TextSpan(text: "All "),
                            TextSpan(
                                text: "Categories",
                                style: TextStyle(color: mainCol)),
                          ],
                        ),
                      ),
                      centerTitle: true,
                    ),
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
