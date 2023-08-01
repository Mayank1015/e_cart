import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_cart/pages/item_details_page.dart';
import 'package:e_cart/utils/home_page_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:e_cart/utils/cart_provider.dart';
import 'package:e_cart/pages/landing_page.dart';
import 'package:e_cart/models/item_model.dart';
import 'package:e_cart/models/user_model.dart';
import 'package:e_cart/models/cart_model.dart';
import 'package:badges/badges.dart' as badges;
import 'package:e_cart/utils/db_helper.dart';
import 'package:e_cart/pages/cart_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:e_cart/utils/spf.dart';
import 'package:badges/badges.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  DBHelper? dbHelper= DBHelper();
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('itemList');

  // final FirebaseAuth auth = FirebaseAuth.instance;
  // late final User? user;
  // late final uid;
  //
  // // late UserModel userData;
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   inputData();
  // }

  // void inputData() {
  //   user = auth.currentUser;
  //   uid = user!.uid;
    // userData.name= auth.currentUser!.displayName!;
    // userData.email= user!.email!;
  // }

  @override
  Widget build(BuildContext context) {

    final cart= Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
      ),

      drawer: const HomePageDrawer(), //Drawer

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Hello, mate",
                style: TextStyle(
                    fontSize: 18,
                    letterSpacing: 0.3,
                    color: Colors.black54
                ),
              ),

              const SizedBox(height: 10,),

              const Text("What are you buying today?",
                style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5
                ),
              ),

              const SizedBox(height: 30,),

              const Text("Available Items",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.7,
                  fontSize: 17,
                  color: Colors.black38

                ),
              ),

              const SizedBox(height: 15,),

              showItemList(cart),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const CartPage()));
        },
        foregroundColor: Colors.white,
        elevation: 0,
        backgroundColor: Colors.black,
        child: badges.Badge(
          badgeStyle: const BadgeStyle(
            badgeColor: Colors.red,
          ),
          badgeContent: Consumer<CartProvider>(
            builder: (context, value, child){
              return Text(value.getCounter().toString(),
                style: const TextStyle(
                  color: Colors.white
                ),
              );
            },
          ),
            child: const Icon(Icons.shopping_cart_rounded, )
        ),
      ),
    );
  }

  Widget showItemList(cart){
    return StreamBuilder<QuerySnapshot>(
      stream: usersCollection.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<DocumentSnapshot> documents = snapshot.data!.docs;
          return ListView.builder(

            itemCount: documents.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final DocumentSnapshot document = documents[index];
              return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: InkWell(
                    onTap: (){
                      ItemModel data= ItemModel(
                        name: document['itemName'],
                        desc: document['itemDesc'],
                        price: document['itemPrice'],
                        imgLink: document['itemImg'],
                        itemType: document['itemType'],
                      );
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ItemDetails(data: data)));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black12, width: 1)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Image(
                                width: 100,
                                height: 100,
                                image: NetworkImage(document['itemImg'])
                            ),

                            const SizedBox(width: 15,),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10,),

                                  Text(document['itemName'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17,
                                        letterSpacing: 0.3,
                                        color: Colors.black
                                    ),
                                  ),

                                  const SizedBox(height: 5,),

                                  Text(document['itemType'],
                                    style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey
                                    ),
                                  ),

                                  const SizedBox(height: 5,),

                                  Text("Price: Rs ${document['itemPrice']}/${document['itemUnit']}",
                                    style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            InkWell(
                              onTap: (){
                                dbHelper!.insert(
                                    Cart(
                                      id: index.toString(),
                                      productId: index.toString(),
                                      productName: document['itemName'],
                                      initialPrice: document['itemPrice'],
                                      productPrice: document['itemPrice'],
                                      quantity: "1".toString(),
                                      unitTag: document['itemUnit'],
                                      image: document['itemImg'],
                                      productType: document['itemType'],
                                    )
                                ).then((value) => {
                                  debugPrint('Product is added to cart'),
                                  cart.addTotalPrice(double.parse(document['itemPrice'].toString())),
                                  cart.addCounter(),
                                }).onError((error, stackTrace)=>
                                {
                                  debugPrint("My error--- $error")
                                });
                              },
                              child: Container(
                                width: 80,
                                height: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  // color: Colors.green,
                                    border: Border.all(color: Colors.black38),
                                    borderRadius: BorderRadius.circular(50)
                                ),

                                child: const Text("+ Add",
                                  style: TextStyle(
                                      color: Colors.black45
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
