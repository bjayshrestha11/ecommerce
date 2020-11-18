import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:app/constants/colors.dart';
import 'package:app/constants/icons.dart';
import 'package:app/models/cartItem.dart';
import 'package:app/services/db_services.dart';
import 'package:app/sharedPrefs/preferences.dart';
import 'package:app/src/cart/cart.dart';
import 'package:app/src/explore/explore.dart';
import 'package:app/src/orders/myOrders.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController _pageController;
  int _page = 0;
  String _userID;
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  getUserId() async {
    _userID = await Prefs.getuserId();
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
        backgroundColor: mainCol,
        currentIndex: _page,
        onTap: navigationTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: secondCol,
        unselectedItemColor: bgCol,
        items: [
          BottomNavigationBarItem(
            icon: Icon(exploreIcon),
            label: "Explore",
            backgroundColor: mainCol,
          ),
          BottomNavigationBarItem(
            icon: Icon(orderIcon),
            label: "Orders",
            backgroundColor: mainCol,
          ),
          BottomNavigationBarItem(
            icon: Badge(
              badgeColor: secondCol,
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
            backgroundColor: mainCol,
          ),
        ],
      ),
    );
  }
}
