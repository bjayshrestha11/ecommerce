import 'package:app/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/cartProvider.dart';
import 'providers/image_upload_provider.dart';
import 'src/home/home.dart';
import 'src/myAccount/myAccount.dart';
import 'src/search/searchScreen.dart';
import 'src/thankyou/thankyou.dart';

import 'resources/userRepository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => UserRepository.instance()),
        ChangeNotifierProvider(create: (_) => ImageUploadProvider()),
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
      ],
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ecommerce",
      debugShowCheckedModeBanner: false,
      theme: context.watch<ThemeNotifier>().darkTheme ? dark : light,
      initialRoute: "/",
      routes: {
        "/": (_) => Home(),
        "/searchScreen": (_) => SearchScreen(),
        "/myAccount": (_) => MyAccount(),
        "/thankYou": (_) => ThankYou(),
      },
    );
  }
}
