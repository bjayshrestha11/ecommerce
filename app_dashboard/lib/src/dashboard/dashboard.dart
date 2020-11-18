import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:foodly_dashboard/components/appbar.dart';
import 'package:foodly_dashboard/constants/colors.dart';
import 'package:foodly_dashboard/constants/icons.dart';
import 'package:foodly_dashboard/constants/styles.dart';
import 'package:foodly_dashboard/models/category.dart';
import 'package:foodly_dashboard/models/message.dart';
import 'package:foodly_dashboard/models/product.dart';
import 'package:foodly_dashboard/models/totalSale.dart';
import 'package:foodly_dashboard/services/db_services.dart';
import 'package:foodly_dashboard/src/dashboard/widget/dashTile.dart';
import 'package:foodly_dashboard/utilities/utils.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  List<Message> messagesList;

  _configureFirebaseListeners() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
        _setMessage(message);
        Navigator.of(context).pushNamed("/dashProcessingOrder");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
        Navigator.of(context).pushNamed("/dashProcessingOrder");
        _setMessage(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume: $message');
        _setMessage(message);
        Navigator.of(context).pushNamed("/dashProcessingOrder");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true),
    );
  }

  _setMessage(Map<String, dynamic> message) {
    final notification = message['notification'];
    final data = message['data'];
    final String title = notification['title'];
    final String body = notification['body'];
    String mMessage = data['message'];
    print("Title: $title, body: $body, message: $mMessage");
    setState(() {
      Message msg = Message(title, body, mMessage);
      messagesList.add(msg);
    });
  }

  _getToken() {
    _firebaseMessaging.getToken().then((token) {
      print("Device Token: $token");
    });
  }

  @override
  void initState() {
    super.initState();
    _getToken();
    _configureFirebaseListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: dashboardIcon,
        title: Text(
          "Foodly Dashboard",
          style: appTitleStyle,
        ),
        centerTitle: false,
        actions: [
          // IconButton(
          //   icon: Icon(Icons.notifications, color: secondCol,),
          //   onPressed: () {
          //     Navigator.of(context).push(MaterialPageRoute(builder: (_){
          //       return Notifications(messagesList: messagesList,);
          //     }));
          //   },
          // ),
        ],
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
                    routeName: "/dashOrders",
                    icon: orderIcon,
                    name: "ORDERS",
                  ),
                  DashTile(
                    routeName: "/dashProducts",
                    icon: Icons.fastfood,
                    name: "PRODUCTS",
                  ),
                  // DashTile(
                  //   routeName: "/dashCarts",
                  //   icon: Icons.shopping_cart,
                  //   name: "CARTS",
                  // ),
                  DashTile(
                    routeName: "/dashCategories",
                    icon: Icons.category,
                    name: "CATEGORIES",
                  ),
                  DashTile(
                    routeName: "/dashCompletedOrder",
                    icon: Icons.done_all,
                    name: "COMPLETED ORDERS",
                  ),
                  DashTile(
                    routeName: "/dashProcessingOrder",
                    icon: Icons.hourglass_empty,
                    name: "PROCESSING ORDERS",
                  ),
                ],
              ),
            ),
            //Total Sales
            Padding(
              padding: const EdgeInsets.only(left: 25.0, top: 10.0, bottom: 5),
              child: Text(
                "TOTAL SALES",
                style: TextStyle(fontSize: 20.0, color: mainCol),
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
