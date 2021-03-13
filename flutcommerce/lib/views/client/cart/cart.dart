import 'package:flutcommerce/core/components/quietBox.dart';
import 'package:flutcommerce/core/constants.dart';
import 'package:flutcommerce/helpers/firebaseDb.dart';
import 'package:flutcommerce/models/cartItem.model.dart';
import 'package:flutcommerce/utilities/utils.dart';
import 'package:flutcommerce/views/client/cart/widgets/cartItemTile.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart({Key key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  // String _userID;
  // String _deliveryAddress;
  // String _emailAddress;
  // int _mobileNumber;
  // List<CartItem> _cartLists;
  // int _total = 0;
  // getUserPrefs() async {
  //   _userID = await Prefs.getuserId();
  //   _deliveryAddress = await Prefs.getuserAddress();
  //   _emailAddress = await Prefs.getuserEmail();
  //   _mobileNumber = await Prefs.getuserPhoneNumber();
  //   setState(() {
  //     // print("User Id - $_userID");
  //     // print("Delivery Address - $_deliveryAddress");
  //     // print("Email Address - $_emailAddress");
  //     // print("Mobile Number - $_mobileNumber");
  //   });
  // }

  // @override
  // void initState() {
  //   getUserPrefs();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // setCartList(List<CartItem> carts) {
    //   context.read<CartProvider>().setCartList(carts);
    //   _cartLists = carts;
    // }

    // setTotal(int total) {
    //   _total = total;
    //   // print("Total - $_total");
    // }

    // deleteCartItems(){
    //   context.read<CartProvider>().deleteCart();
    // }
    return Scaffold(
      // backgroundColor: bgCol,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              child: Container(
                // margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //my cart
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 10),
                      margin: EdgeInsets.symmetric(horizontal: 16.0),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color: black,
                              fontSize: 26.0,
                              fontWeight: FontWeight.w800),
                          children: <TextSpan>[
                            TextSpan(text: "My\n"),
                            TextSpan(
                                text: "Cart",
                                style: TextStyle(
                                    color: mainCol,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w800)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),

                    // _userID != null
                    //     ?Container():
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.0),
                      height: Utils.getHeightByPercentage(context, 50),
                      child: QuietBox(
                        imgPath: "assets/images/login.png",
                        text: "Login First To Add & View Cart",
                        btnText: "Login Now",
                        routeName: "/myAccount",
                      ),
                    ),
                    //list of cart items
                    // _userID == null
                    //     ? Container()
                    //     : 
                        Flexible(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 16.0),
                              height: Utils.getHeightByPercentage(context, 50),
                              child: StreamBuilder(
                                stream: cartItemDb.streamListByUserId("TMNBRLDMGUR6SQQ9URYN3Nh5nT12"),
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<CartItem>> snapshot) {
                                  if (snapshot.hasError)
                                    return QuietBox(
                                      imgPath: "assets/images/error.png",
                                      btnText: "Something went Wrong",
                                    );
                                  if (snapshot.hasData) {
                                    var docList = snapshot.data;
                                    // setCartList(docList);
                                    if (docList.isEmpty) {
                                      // return Center(
                                      //     child: Text("Your Cart is Empty."));
                                      return QuietBox(
                                        imgPath: "assets/images/empty_cart.png",
                                        text: "Your cart is Empty",
                                      );
                                    }
                                    return ListView.builder(
                                      itemCount: docList.length,
                                      itemBuilder: (_, i) {
                                        return CartItemTile(
                                          cartItem: snapshot.data[i],
                                          index: i,
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
                    // //delevery
                    // _userID == null
                    //     ? Container()
                    //     : Container(
                    //         margin: EdgeInsets.only(top: 10),
                    //         child: Row(
                    //           children: [
                    //             /*SizedBox(
                    //               width:
                    //                   Utils.getWidthByPercentage(context, 25),
                    //             ),*/
                    //             /* Container(
                    //               width:
                    //                   Utils.getWidthByPercentage(context, 40),
                    //               child: Text(
                    //                 "Delivery",
                    //                 style: TextStyle(
                    //                     fontSize: 16.0, color: secondCol),
                    //               ),
                    //             ),
                    //             Container(
                    //               width:
                    //                   Utils.getWidthByPercentage(context, 20),
                    //               child: Text(
                    //                 "NRs. 0",
                    //                 style: TextStyle(
                    //                     fontSize: 16.0, color: secondCol),
                    //               ),
                    //             ),*/
                    //           ],
                    //         ),
                    //       ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: Container(
                        height: 1.0,
                        width: double.infinity,
                        color: mainCol,
                      ),
                    ),
                    //total
                    //total
                    // _userID == null
                    //     ? Container()
                    //     :
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total",
                            style: TextStyle(fontSize: 21.0, color: secondCol),
                          ),
                          // _userID == null
                          //     ? Text(
                          //         "NRs. 0",
                          //         style: TextStyle(
                          //             fontSize: 21.0, color: secondCol),
                          //       ):
                          StreamBuilder(
                            stream: cartItemDb.streamListByUserId("TMNBRLDMGUR6SQQ9URYN3Nh5nT12"),
                            builder:
                                (_, AsyncSnapshot<List<CartItem>> snapshot) {
                              if (snapshot.hasData) {
                                var docList = snapshot.data;
                                var total = 0;
                                for (int i = 0; i < docList.length; i++) {
                                  var cartItem = docList[i];
                                  total = total +
                                      (cartItem.quantity * cartItem.price);
                                }
                                // setTotal(total);
                                return Text(
                                  "NRs. $total",
                                  style: TextStyle(
                                      fontSize: 21.0, color: secondCol),
                                );
                              }
                              return Text(
                                "NRs. 0",
                                style:
                                    TextStyle(fontSize: 21.0, color: secondCol),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    //chekout
                    // _userID == null
                    //     ? Container()
                    //     :
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.green),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(40),
                                        bottomLeft: Radius.circular(40)),
                                  ),
                                ),
                              ),
                              // color: mainCol,
                              // textColor: secondCol,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 18.0, horizontal: 32.0),
                                child: Text(
                                  "Checkout",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              onPressed: () async {
                                // if (_userID == null ||
                                //     _emailAddress == null) {
                                //   Navigator.of(context)
                                //       .pushNamed("/myAccount");
                                // } else if (_cartLists.isEmpty) {
                                //   Utils.showToast("Your Cart is Empty");
                                // } else {
                                // Navigator.of(context).push(
                                //     MaterialPageRoute(builder: (_) {
                                //   return Checkout(
                                //     cartList: _cartLists,
                                //     deliveryAddress: _deliveryAddress,
                                //     emailAddress: _emailAddress,
                                //     phoneNumber: _mobileNumber,
                                //     total: _total,
                                //     userId: _userID,
                                //   );
                                // }));
                                // Order myOrder = Order(
                                //   deliveryAddress: _deliveryAddress,
                                //   emailAddress: _emailAddress,
                                //   mobileNumber: _mobileNumber,
                                //   orderDate: DateTime.now(),
                                //   orderState: "processing",
                                //   orderedItems: _cartLists.map((cartItem){
                                //     OrderedItem orderedItem = OrderedItem(
                                //       name: cartItem.name,
                                //       imageUrl: cartItem.imageUrl,
                                //       price: cartItem.price,
                                //       productId: cartItem.productId,
                                //       quantity: cartItem.quantity,
                                //     );
                                //     return orderedItem;
                                //   }).toList(),
                                //   // orderedItems: [],
                                //   totalAmount: _total,
                                //   userId: _userID,
                                // );
                                // orderItemDb.createItem(myOrder);
                                // deleteCartItems();
                                // Utils.showToast("Order Placed Successfully");
                                // }
                              },
                            ),
                          ],
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
