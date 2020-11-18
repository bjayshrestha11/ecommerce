import 'package:flutter/material.dart';
import 'package:foodly_dashboard/components/appbar.dart';
import 'package:foodly_dashboard/components/quietBox.dart';
import 'package:foodly_dashboard/constants/colors.dart';
import 'package:foodly_dashboard/constants/icons.dart';
import 'package:foodly_dashboard/constants/strings.dart';
import 'package:foodly_dashboard/models/order.dart';
import 'package:foodly_dashboard/models/totalSale.dart';
import 'package:foodly_dashboard/services/db_services.dart';
import 'package:foodly_dashboard/src/dashboard/widget/dashOrderTile.dart';
import 'package:foodly_dashboard/utilities/utils.dart';

class DashOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TotalSale uptotalSale;
    void getTotalSale() async {
      List<TotalSale> totalSale = await totalSaleDb.getQueryList();
      uptotalSale = totalSale[0];
    }

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
                                text: "Orders",
                                style: TextStyle(color: mainCol)),
                          ],
                        ),
                      ),
                      centerTitle: true,
                    ),
                    //all orders
                    Flexible(
                      child: Container(
                        height: Utils.getHeightByPercentage(context, 76),
                        color: bgCol,
                        child: StreamBuilder(
                          stream: orderItemDb.streamOrderList(),
                          builder: (BuildContext context, snapshot) {
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
                                  text: "No Orders Found.",
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
                                  Order order = docList[i];
                                   getTotalSale();
                                  return DashOrderTile(
                                    order: order,
                                    onDelete: (order) {
                                      orderItemDb.removeItem(order.id);
                                    },
                                    onCompleted: (order) {
                                      getTotalSale();
                                      Order upOrder = Order(
                                        coupon: order.coupon,
                                        deliveryAddress: order.deliveryAddress,
                                        emailAddress: order.emailAddress,
                                        id: order.id,
                                        mobileNumber: order.mobileNumber,
                                        orderDate: order.orderDate,
                                        orderState: COMPLETED,
                                        orderedItems: order.orderedItems,
                                        specialNote: order.specialNote,
                                        totalAmount: order.totalAmount,
                                        userId: order.userId,
                                      );
                                      orderItemDb.updateItem(upOrder);
                                     
                                      TotalSale item = TotalSale(
                                        id: uptotalSale.id,
                                        sale: uptotalSale.sale +
                                            upOrder.totalAmount,
                                        updateDate: DateTime.now(),
                                      );
                                      totalSaleDb.updateItem(item);
                                      Utils.showToast("Total Sale - ${item.sale}");
                                    },
                                    onProcessing: (order) {
                                      getTotalSale();
                                      Order upOrder = Order(
                                        coupon: order.coupon,
                                        deliveryAddress: order.deliveryAddress,
                                        emailAddress: order.emailAddress,
                                        id: order.id,
                                        mobileNumber: order.mobileNumber,
                                        orderDate: order.orderDate,
                                        orderState: PROCESSING,
                                        orderedItems: order.orderedItems,
                                        specialNote: order.specialNote,
                                        totalAmount: order.totalAmount,
                                        userId: order.userId,
                                      );
                                      orderItemDb.updateItem(upOrder);
                                      TotalSale item = TotalSale(
                                        id: uptotalSale.id,
                                        sale: uptotalSale.sale -
                                            upOrder.totalAmount,
                                        updateDate: DateTime.now(),
                                      );
                                      totalSaleDb.updateItem(item);
                                      Utils.showToast("Total Sale - ${item.sale}");
                                    },
                                  );
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
    );
  }
}
