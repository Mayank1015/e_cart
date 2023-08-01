import 'package:e_cart/pages/login_page.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset("assets/img1.png"),

                  const Text("Shop smart, Shop easy, \nanytime, anywhere, \nwith us!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                ],
              ),
            )
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child:  InkWell(
          onTap: ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LogInPage())),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(10),
              // border: Border.all(width: 2, color: Colors.black,)
            ),
            child: const Text("Get Started",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                  fontSize: 18
              ),
            ),
          ),
        ),
      ),
    );
  }
}
