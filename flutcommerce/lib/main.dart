
import 'package:firebase_core/firebase_core.dart';
import 'package:flutcommerce/bindings/instanceBinding.dart';
import 'package:flutcommerce/views/admin/admin.view.dart';
import 'package:flutcommerce/views/admin/dashCarts.dart/dashCarts.dart';
import 'package:flutcommerce/views/admin/dashCategories/dashCategories.dart';
import 'package:flutcommerce/views/admin/dashOrders/dashCompletedOrder.dart';
import 'package:flutcommerce/views/admin/dashOrders/dashOrders.dart';
import 'package:flutcommerce/views/admin/dashOrders/dashProcessingOrder.dart';
import 'package:flutcommerce/views/admin/dashProducts/dashProducts.dart';
import 'package:flutcommerce/views/auth/login.view.dart';
import 'package:flutcommerce/views/auth/register.view.dart';
import 'package:flutcommerce/views/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InstanceBinding(),
      debugShowCheckedModeBanner: false,
      title: "Flut Commerce",
      initialRoute: "/",
      getPages: [
        GetPage(name: '/', page: () => Wrapper()),
        GetPage(name: '/login', page: () => LoginWidget()),
        GetPage(name: '/register', page: () => RegistrationWidget()),
        GetPage(name: '/admin', page: () => AdminWidget()),
        GetPage(name: '/admin/dashOrders', page: () => DashOrders()),
        GetPage(name: '/admin/dashCompletedOrder', page: () => DashCompletedOrder()),
        GetPage(name: '/admin/dashProcessingOrder', page: () => DashProcessingOrder()),
        GetPage(name: '/admin/dashCategories', page: () => DashCategories()),
        GetPage(name: '/admin/dashProducts', page: () => DashProducts()),
        GetPage(name: '/admin/dashCarts', page: () => DashCarts()),
      ],
      routes: {
        '/welcome':(context) => AdminWidget(),
        '/login':(context)=> LoginWidget(),
        '/reg':(context)=>RegistrationWidget(),
        '/dashboard':(context)=>AdminWidget(),
      },
    );
  }
}
