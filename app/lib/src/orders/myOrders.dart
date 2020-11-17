import 'package:flutter/material.dart';
import 'package:app/src/orders/widget/orderTile.dart';
import 'package:app/components/quietBox.dart';
import 'package:app/constants/colors.dart';
import 'package:app/models/order.dart';
import 'package:app/services/db_services.dart';
import 'package:app/utilities/utils.dart';

class MyOrders extends StatelessWidget {
  final String userID;
  MyOrders({@required this.userID});
  @override
  Widget build(BuildContext context) {
    print(userID);
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
                    //my orders
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 10),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color: black,
                              fontSize: 26.0,
                              fontWeight: FontWeight.w800),
                          children: <TextSpan>[
                            TextSpan(text: "My\n"),
                            TextSpan(
                                text: "Orders",
                                style: TextStyle(
                                    color: mainCol,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w800)),
                          ],
                        ),
                      ),
                    ),
                    //my orders stream list
                    userID == null
                        ? QuietBox(
                            imgPath: "assets/images/login.png",
                            text: "Login to see your orders",
                            btnText: "Login Now",
                            routeName: "/myAccount",
                          )
                        : Flexible(
                            child: Container(
                              height: Utils.getHeightByPercentage(context, 76),
                              color: bgCol,
                              child: StreamBuilder(
                                stream:
                                    orderItemDb.streamOrderListByUserId(userID),
                                builder: (BuildContext context, snapshot) {
                                  if (snapshot.hasError)
                                    return QuietBox(
                                      imgPath: "assets/images/error.png",
                                      btnText: "Something went Wrong",
                                    );
                                  if (snapshot.hasData) {
                                    var docList = snapshot.data;
                                    if (docList.isEmpty) {
                                      return QuietBox(
                                        imgPath:
                                            "assets/images/empty_state.png",
                                        text: "Your order is Empty",
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
                                        return OrderTile(
                                          order: order,
                                          onDelete: (Order order) {
                                            orderItemDb.removeItem(order.id);
                                          },
                                        );
                                      },
                                    );
                                  }
                                  return Container();
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
