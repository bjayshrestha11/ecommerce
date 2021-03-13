import 'package:flutcommerce/core/constants.dart';
import 'package:flutcommerce/helpers/firebaseDb.dart';
import 'package:flutcommerce/models/category.model.dart';
import 'package:flutcommerce/models/product.model.dart';
import 'package:flutcommerce/models/totalSale.model.dart';
import 'package:flutcommerce/utilities/utils.dart';
import 'package:flutcommerce/views/admin/widgets/dashTile.dart';
import 'package:flutter/material.dart';

class AdminWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Orders, Products, Add Products, Processing Orders
            Container(
              // height: Utils.getHeightByPercentage(context, 50),
              width: Utils.getWidthByPercentage(context, 100),
              margin: EdgeInsets.all(10),
              child: Wrap(
                alignment: WrapAlignment.spaceEvenly,
                children: [
                  //Orders Tile
                  DashTile(
                    routeName: "/admin/dashOrders",
                    icon: ordersIcon,
                    name: "ORDERS",
                    color: Colors.green,
                    bgCol: Colors.white,
                  ),
                  DashTile(
                    routeName: "/admin/dashProducts",
                    icon: productsIcon,
                    name: "PRODUCTS",
                    color: Colors.blue,
                    bgCol: Colors.white,
                  ),
                  // DashTile(
                  //   routeName: "/admin/dashCarts",
                  //   icon: Icons.shopping_cart,
                  //   name: "CARTS",
                  // ),
                  DashTile(
                    routeName: "/admin/dashCategories",
                    icon: categoriesIcon,
                    name: "CATEGORIES",
                    color: Colors.purple,
                    bgCol: Colors.white,
                  ),
                  DashTile(
                    routeName: "/admin/dashCategories",
                    icon: brandsIcon,
                    name: "BRANDS",
                    color: Colors.indigo,
                    bgCol: Colors.white,
                  ),
                  DashTile(
                    routeName: "/admin/dashCompletedOrder",
                    icon: completedIcon,
                    name: "COMPLETED ORDERS",
                    color: Colors.teal,
                    bgCol: Colors.white,
                  ),
                  DashTile(
                    routeName: "/admin/dashProcessingOrder",
                    icon: processingIcon,
                    name: "PROCESSING ORDERS",
                    color: Colors.yellow,
                    bgCol: Colors.white,
                  ),
                ],
              ),
            ),
            //Total Sales
            Padding(
              padding: const EdgeInsets.only(left: 25.0, top: 10.0, bottom: 5),
              child: Text(
                "TOTAL SALES",
                style: TextStyle(fontSize: 20.0, color: Colors.red),
              ),
            ),
            //TSA
            Padding(
              padding: const EdgeInsets.only(left: 25.0, top: 5.0, bottom: 5),
              // child: Text(
              //   "NRs. 1000",
              //   style: TextStyle(fontSize: 20.0, color: secondCol),
              // ),
              child: StreamBuilder(
                stream: totalSaleDb.streamList(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<TotalSale>> snapshot) {
                  if (snapshot.hasError)
                    return Text(
                      "error",
                      style: TextStyle(fontSize: 20.0, color: secondCol),
                    );
                  if (snapshot.hasData) {
                    var docList = snapshot.data;
                    if (docList.isEmpty) {
                      return Text(
                        "empty",
                        style: TextStyle(fontSize: 20.0, color: secondCol),
                      );
                    }
                    TotalSale totalSale = docList[0];
                    return Text(
                      "${totalSale.sale}",
                      style: TextStyle(fontSize: 20.0, color: secondCol),
                    );
                  }
                  return Text(
                    "...",
                    style: TextStyle(fontSize: 20.0, color: secondCol),
                  );
                },
              ),
            ),
            //PRODUCT COUNT
            Padding(
              padding: const EdgeInsets.only(left: 25.0, top: 10.0, bottom: 5),
              child: Text(
                "PRODUCT COUNT",
                style: TextStyle(fontSize: 20.0, color: mainCol),
              ),
            ),
            //PC
            Padding(
              padding: const EdgeInsets.only(left: 25.0, top: 5.0, bottom: 5),
              child: StreamBuilder(
                stream: productItemDb.streamList(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Product>> snapshot) {
                  if (snapshot.hasError)
                    return Text(
                      "0",
                      style: TextStyle(fontSize: 20.0, color: secondCol),
                    );
                  if (snapshot.hasData) {
                    var docList = snapshot.data;
                    if (docList.isEmpty) {
                      return Text(
                        "0",
                        style: TextStyle(fontSize: 20.0, color: secondCol),
                      );
                    }

                    return Text(
                      "${docList.length}",
                      style: TextStyle(fontSize: 20.0, color: secondCol),
                    );
                  }
                  return Text(
                    "...",
                    style: TextStyle(fontSize: 20.0, color: secondCol),
                  );
                },
              ),
            ),
            //Category COUNT
            Padding(
              padding: const EdgeInsets.only(left: 25.0, top: 10.0, bottom: 5),
              child: Text(
                "CATEGORY COUNT",
                style: TextStyle(fontSize: 20.0, color: mainCol),
              ),
            ),
            //PC
            Padding(
              padding: const EdgeInsets.only(left: 25.0, top: 5.0, bottom: 5),
              child: StreamBuilder(
                stream: categoryItemDb.streamList(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Category>> snapshot) {
                  if (snapshot.hasError)
                    return Text(
                      "0",
                      style: TextStyle(fontSize: 20.0, color: secondCol),
                    );
                  if (snapshot.hasData) {
                    var docList = snapshot.data;
                    if (docList.isEmpty) {
                      return Text(
                        "0",
                        style: TextStyle(fontSize: 20.0, color: secondCol),
                      );
                    }

                    return Text(
                      "${docList.length}",
                      style: TextStyle(fontSize: 20.0, color: secondCol),
                    );
                  }
                  return Text(
                    "...",
                    style: TextStyle(fontSize: 20.0, color: secondCol),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
