import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_cart/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_cart/utils/toast.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {

  final _formKey= GlobalKey<FormState>();
  final _emailController= TextEditingController();
  final _nameController= TextEditingController();
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
                  const Text("Create Account ",
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
                                child: Text( 'Name',
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
                        controller: _nameController,
                        // keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromRGBO(245, 245, 245, 1),
                          hintText: 'Enter your name',
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
                        keyboardType: TextInputType.emailAddress,
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
                ],
              ),
            ),
          ),
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: InkWell(
          onTap: ()=> {
            if(_formKey.currentState!.validate()){
              _auth.createUserWithEmailAndPassword(
                  email: _emailController.text.toString(),
                  password: _passwordController.text.toString()
              ).then((value) {
                FirebaseFirestore.instance.collection('userData').doc(value.user?.uid).set({
                  "name": _nameController.text,
                  "email": _emailController.text,
                });

                FToast().toastSuccessMessage("Account created successfully");

                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LogInPage()));
                
              }).onError((error, stackTrace){
                FToast().toastErrorMessage(error.toString());
              })
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text("Create",
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
