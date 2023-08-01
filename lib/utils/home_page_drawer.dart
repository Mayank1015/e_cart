import 'package:e_cart/pages/landing_page.dart';
import 'package:e_cart/pages/cart_page.dart';
import 'package:e_cart/utils/spf.dart';
import 'package:flutter/material.dart';

class HomePageDrawer extends StatelessWidget {
  const HomePageDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black87,
            ), //BoxDecoration
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.transparent),
              accountName: Text(
                "Username",
                style: TextStyle(fontSize: 20),
              ),
              accountEmail: Text("user977@gmail.com"),
              currentAccountPictureSize: Size.square(40),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Color.fromARGB(255, 165, 255, 137),
                child: Text(
                  "U",
                  style: TextStyle(fontSize: 30.0, color: Colors.blue),
                ), //Text
              ), //circleAvatar
            ), //UserAccountDrawerHeader
          ), //DrawerHeader
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text(' My Profile '),
            onTap: () {
              // Navigator.pop(context);
              // debugPrint("Name: "+ userData.name);
            },
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text(' My Cart '),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const CartPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('LogOut'),
            onTap: () {
              SPF.prefs.setBool("isLoggedIn", false);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LandingPage()));
            },
          ),
        ],
      ),
    );
  }
}
