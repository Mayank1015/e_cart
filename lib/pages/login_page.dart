import 'package:e_cart/pages/create_account.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_cart/pages/home_page.dart';
import 'package:e_cart/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:e_cart/utils/spf.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final _formKey= GlobalKey<FormState>();
  final _emailController= TextEditingController();
  final _passwordController= TextEditingController();

  final FirebaseAuth _auth= FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Shop your way, ",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                    ),
                  ),

                  const SizedBox(height: 30,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 10.0, bottom: 5),
                        child: Text.rich(
                          TextSpan(
                            children: <InlineSpan>[
                              WidgetSpan(
                                child: Text( 'Email',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87
                                  ),
                                ),
                              ),
                              WidgetSpan(
                                child: Text( '*',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      TextField(
                        autofocus: false,
                        controller: _emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromRGBO(245, 245, 245, 1),
                          hintText: 'Enter your email',
                          hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 13
                          ),

                          border: InputBorder.none,

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                                width: 0, color: Colors.transparent),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                                width: 1, color: Colors.black12),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 10.0, bottom: 5),
                        child: Text.rich(
                          TextSpan(
                            children: <InlineSpan>[
                              WidgetSpan(
                                child: Text( 'Password',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87
                                  ),
                                ),
                              ),
                              WidgetSpan(
                                child: Text( '*',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      TextField(
                        autofocus: false,
                        obscureText: true,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromRGBO(245, 245, 245, 1),
                          hintText: 'Enter your password',
                          hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 13
                          ),

                          border: InputBorder.none,

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                                width: 0, color: Colors.transparent),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                                width: 1, color: Colors.black12),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: (){},
                          child: const Text("Forgot Password?",
                            style: TextStyle(
                              color: Colors.grey
                            ),
                          )
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const CreateAccount()));
                },
                child: const Text("Create New Account?",
                  style: TextStyle(
                      color: Colors.grey,
                    letterSpacing: 0.3,
                  ),
                )
            ),

            InkWell(
              onTap: ()=> {
                login(),
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(10),
                  // border: Border.all(width: 2, color: const Color.fromRGBO(119, 133, 219, 1),)
                ),
                child: const Text("LogIn",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      fontSize: 18
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void login(){
    _auth.signInWithEmailAndPassword(
        email: _emailController.text.toString(),
        password: _passwordController.text.toString()
    ).then((value){
      SPF.prefs.setBool("isLoggedIn", true);
      FToast().toastSuccessMessage("Login successful");
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const HomePage()));
    }).onError((error, stackTrace){
      FToast().toastErrorMessage(error.toString());
    });
  }
}
