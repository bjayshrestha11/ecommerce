import 'package:flutter/material.dart';
import 'package:foodly_dashboard/src/dashboard/dashCarts.dart/dashCarts.dart';
import 'package:foodly_dashboard/src/dashboard/dashCategories/dashCategories.dart';
import 'package:foodly_dashboard/src/dashboard/dashOrders/dashCompletedOrder.dart';
import 'package:foodly_dashboard/src/dashboard/dashOrders/dashOrders.dart';
import 'package:foodly_dashboard/src/dashboard/dashOrders/dashProcessingOrder.dart';
import 'package:foodly_dashboard/src/dashboard/dashProducts/dashProducts.dart';
import 'package:foodly_dashboard/src/dashboard/dashboard.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    App(),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Foodly Dashboard",
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/":(_) => Dashboard(),
        "/dashboard":(_) => Dashboard(),
        "/dashOrders":(_) => DashOrders(),
        "/dashCompletedOrder":(_) => DashCompletedOrder(),
        "/dashProcessingOrder":(_) => DashProcessingOrder(),
        "/dashCategories":(_) => DashCategories(),
        "/dashProducts":(_) => DashProducts(),
        "/dashCarts":(_) => DashCarts(),
      },
    );
  }
}
