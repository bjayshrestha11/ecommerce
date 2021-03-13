import 'package:connectivity/connectivity.dart';
import 'package:flutcommerce/core/constants.dart';
import 'package:flutcommerce/helpers/firebaseDb.dart';
import 'package:flutcommerce/models/cartItem.model.dart';
import 'package:flutcommerce/models/order.model.dart';
import 'package:flutcommerce/utilities/utils.dart';
import 'package:flutter/material.dart';

class Checkout extends StatefulWidget {
  final String userId;
  final int total;
  final String deliveryAddress;
  final String emailAddress;
  final int phoneNumber;
  final List<CartItem> cartList;
  Checkout({
    @required this.deliveryAddress,
    @required this.emailAddress,
    @required this.phoneNumber,
    @required this.userId,
    @required this.cartList,
    @required this.total,
  });
  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _deliveryAddress;
  TextEditingController _emailAddress;
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _coupon;
  TextEditingController _specialNote;
  String _deviceLocation = "";
  // void getDeviceLocation() async {
  //   _deviceLocation = await Prefs.getDeviceAddress();
  //   setState(() {});
  // }

  // @override
  // void initState() {
  //   getDeviceLocation();
  //   _deliveryAddress = TextEditingController(text: widget.deliveryAddress);
  //   _emailAddress = TextEditingController(text: widget.emailAddress);
  //   // _phoneNumber = TextEditingController(text: widget.phoneNumber.toString());
  //   _phoneNumber.text = widget.phoneNumber.toString() == "null"
  //       ? ""
  //       : widget.phoneNumber.toString();
  //   _coupon = TextEditingController();
  //   _specialNote = TextEditingController();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // deleteCartItems() {
    //   context.read<CartProvider>().deleteCart();
    // }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: backIcon,
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          "Checkout",
          style: appTitleStyle,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(36),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                //provide feilds piliz
                // delivery address
                TextFormField(
                  validator: (val) {
                    if (val.isEmpty) return "*Delivery Address can't be empty.";
                    return null;
                  },
                  controller: _deliveryAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: "Delivery Address*",
                    labelStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                // email address
                TextFormField(
                  validator: (val) {
                    if (val.isEmpty) return "*Email Address can't be empty.";
                    return null;
                  },
                  controller: _emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: "Email Address*",
                    labelStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                // Phone Number
                TextFormField(
                  validator: (val) {
                    if (val.isEmpty) return "*Phone Number can't be empty.";
                    return null;
                  },
                  controller: _phoneNumber,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: "Phone Number*",
                    labelStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                // Coupon
                TextFormField(
                  validator: (val) {
                    return null;
                  },
                  controller: _coupon,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: "Coupon(Optional)",
                    labelStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                // Special Note
                TextFormField(
                  validator: (val) {
                    return null;
                  },
                  controller: _specialNote,
                  maxLines: 3,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: "Special Note(Optional)",
                    labelStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                //Save Button
                const SizedBox(height: 20.0),
                MaterialButton(
                  color: mainCol,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                  textColor: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Confirm Order",
                      style: TextStyle(color: bgCol),
                    ),
                  ),
                  onPressed: () async {
                    ConnectivityResult connectivity =
                        await Connectivity().checkConnectivity();
                    if (connectivity == ConnectivityResult.none) {
                      Utils.showToast(
                          "Check Your Internet Connection! Try again later.");
                    }
                    if (_formKey.currentState.validate()) {
                      Order myOrder = Order(
                        deliveryAddress: _deliveryAddress.text,
                        emailAddress: _emailAddress.text,
                        mobileNumber: Utils.strToInt(_phoneNumber.text),
                        orderDate: DateTime.now(),
                        orderState: "processing",
                        orderedItems: widget.cartList.map((cartItem) {
                          OrderedItem orderedItem = OrderedItem(
                            name: cartItem.name,
                            imageUrl: cartItem.imageUrl,
                            price: cartItem.price,
                            productId: cartItem.productId,
                            quantity: cartItem.quantity,
                          );
                          return orderedItem;
                        }).toList(),
                        totalAmount: widget.total,
                        userId: widget.userId,
                        coupon: _coupon.text,
                        specialNote: _specialNote.text,
                        deviceLocation: _deviceLocation,
                      );
                      await orderItemDb.createItem(myOrder).then((value) {
                        // deleteCartItems();
                        // Utils.showToast("Order Placed Successfully");
                        // Navigator.of(context).pushReplacementNamed("/thankYou");
                      });
                    } else {
                      Utils.showToast("Fix The Error First");
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
