import 'package:flutcommerce/core/components/quietBox.dart';
import 'package:flutcommerce/core/constants.dart';
import 'package:flutcommerce/helpers/firebaseDb.dart';
import 'package:flutcommerce/models/cartItem.model.dart';
import 'package:flutcommerce/views/admin/dashCarts.dart/dashCartItemTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashCarts extends StatelessWidget {
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
              TextSpan(text: "Carts", style: TextStyle(color: mainCol)),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: cartItemDb.streamList(),
        builder:
            (BuildContext context, AsyncSnapshot<List<CartItem>> snapshot) {
          if (snapshot.hasError)
            return QuietBox(
              imgPath: "assets/images/error.png",
              text: "Oops Something went wrong.",
            );
          if (snapshot.hasData) {
            var docList = snapshot.data;
            if (docList.isEmpty) {
              return QuietBox(
                imgPath: "assets/images/empty_cart.png",
                text: "No Cart Found.",
              );
            }
            return ListView.builder(
              itemCount: docList.length,
              itemBuilder: (_, i) {
                return DashCartItemTile(
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
    );
  }
}
