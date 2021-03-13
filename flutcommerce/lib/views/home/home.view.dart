import 'package:badges/badges.dart';
import 'package:flutcommerce/core/constants.dart';
import 'package:flutcommerce/helpers/firebaseDb.dart';
import 'package:flutcommerce/models/cartItem.model.dart';
import 'package:flutcommerce/views/client/cart/cart.dart';
import 'package:flutcommerce/views/client/explore/explore.dart';
import 'package:flutcommerce/views/client/orders/myOrders.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  PageController _pageController;
  int _page = 0;
  String _userID;
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  getUserId() async {
    // _userID = await Prefs.getuserId();
    _userID = "TMNBRLDMGUR6SQQ9URYN3Nh5nT12";
    setState(() {});
  }

  //List<Message> messagesList;

  // _configureFirebaseListeners() {
  //   _firebaseMessaging.configure(
  //     onMessage: (Map<String, dynamic> message) async {
  //       print('onMessage: $message');
  //       //_setMessage(message);
  //       Navigator.of(context).pushNamed("/");
  //     },
  //     onLaunch: (Map<String, dynamic> message) async {
  //       print('onLaunch: $message');
  //       Navigator.of(context).pushNamed("/");
  //       //_setMessage(message);
  //     },
  //     onResume: (Map<String, dynamic> message) async {
  //       print('onResume: $message');
  //       //_setMessage(message);
  //       Navigator.of(context).pushNamed("/");
  //     },
  //   );
  //   _firebaseMessaging.requestNotificationPermissions(
  //     const IosNotificationSettings(sound: true, badge: true, alert: true),
  //   );
  // }

  /*_setMessage(Map<String, dynamic> message) {
    final notification = message['notification'];
    final data = message['data'];
    final String title = notification['title'];
    final String body = notification['body'];
    String mMessage = data['message'];
    print("Title: $title, body: $body, message: $mMessage");
    setState(() {
      Message msg = Message (title, body, mMessage);
      messagesList.add(msg);
    });
  }*/

  @override
  void initState() {
    _pageController = PageController();
    getUserId();
    super.initState();
    // _configureFirebaseListeners();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      getUserId();
      _page = page;
    });
  }

  void navigationTapped(int page) {
    getUserId();
    _pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          Explore(),
          MyOrders(
            userID: _userID,
          ),
          Cart(),
        ],
        controller: _pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: mainCol,
        currentIndex: _page,
        onTap: navigationTapped,
        type: BottomNavigationBarType.fixed,
        // selectedItemColor: secondCol,
        // unselectedItemColor: bgCol,
        items: [
          BottomNavigationBarItem(
            icon: Icon(exploreIcon),
            label: "Explore",
            // backgroundColor: mainCol,
          ),
          BottomNavigationBarItem(
            icon: Icon(orderIcon),
            label: "Orders",
            // backgroundColor: mainCol,
          ),
          BottomNavigationBarItem(
            icon: Badge(
              badgeColor: Theme.of(context).bottomAppBarColor,
              badgeContent: _userID == null
                  ? Text(
                      "0",
                      style: TextStyle(fontSize: 10.0),
                    )
                  : StreamBuilder(
                      stream: cartItemDb.streamListByUserId(_userID),
                      builder: (_, AsyncSnapshot<List<CartItem>> snapshot) {
                        if (snapshot.hasData) {
                          var docList = snapshot.data;
                          return Text(
                            "${docList.length}",
                            style: TextStyle(fontSize: 10.0),
                          );
                        }
                        return Text(
                          "0",
                          style: TextStyle(fontSize: 10.0),
                        );
                      },
                    ),
              child: Icon(cartIcon),
            ),
            label: "Cart",
            // backgroundColor: mainCol,
          ),
        ],
      ),
    );
  }
}
