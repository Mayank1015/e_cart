import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:e_cart/utils/cart_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_cart/pages/landing_page.dart';
import 'package:e_cart/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:e_cart/utils/spf.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SPF.prefs= await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_)=> CartProvider(),
      child: Builder(
        builder: (
            BuildContext context) =>
            MaterialApp(
              theme: ThemeData(
                textTheme: GoogleFonts.rubikTextTheme(
                  Theme.of(context).textTheme,
                ),
                useMaterial3: true,
              ),
              home: SPF.prefs.getBool("isLoggedIn")== true? const HomePage():  const LandingPage(),
            ),
      ),
    );
  }
}
