import 'package:flutter/material.dart';
import 'package:app_dashboard/components/appbar.dart';
import 'package:app_dashboard/components/quietBox.dart';
import 'package:app_dashboard/constants/colors.dart';
import 'package:app_dashboard/constants/icons.dart';
import 'package:app_dashboard/models/cartItem.dart';
import 'package:app_dashboard/services/db_services.dart';
import 'package:app_dashboard/src/dashboard/dashCarts.dart/dashCartItemTile.dart';

class DashCarts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
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
