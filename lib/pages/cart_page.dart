import 'package:e_cart/utils/cart_provider.dart';
import 'package:e_cart/models/cart_model.dart';
import 'package:e_cart/utils/db_helper.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';


class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  DBHelper? db= DBHelper();

  @override
  Widget build(BuildContext context) {
    final cart= Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: const Text("My Products",
          style: TextStyle(
              letterSpacing: 0.3
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: showCartItems(cart),
          ),
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        height: 100,
        child:  Column(
          children: [
            Consumer<CartProvider>(builder: (context, value, child){
              return Visibility(
                visible: value.getTotalPrice().toStringAsFixed(2) == "0.00"? false: true,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          'Grand Total: ',
                          style: TextStyle(
                            // fontSize: 25,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.3
                          ),
                        ),

                        Text(
                          r'Rs '+value.getTotalPrice().toStringAsFixed(2),
                          style: const TextStyle(
                            // fontSize: 22
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 5,),

            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text("Place Order",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                    fontSize: 18
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget showCartItems(cart){
    return FutureBuilder(
        future: cart.getData(),
        builder: (context, AsyncSnapshot<List<Cart>> snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data?.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black12, width: 1)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image(
                            width: 100,
                            height: 100,
                            image: NetworkImage(snapshot.data![index].image.toString())
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(snapshot.data![index].productName.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  letterSpacing: 0.5,
                                  color: Colors.black
                              ),
                            ),

                            const SizedBox(height: 8,),

                            Text("Rs ${snapshot.data![index].initialPrice.toString()} / ${snapshot.data![index].unitTag.toString()} x ${snapshot.data![index].quantity.toString()}",
                              style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.black54
                              ),
                            ),

                            const SizedBox(height: 2,),
                            Text("Total: Rs ${snapshot.data![index].productPrice.toString()}",
                              style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.black54
                              ),
                            ),
                          ],
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              onPressed: (){
                                db!.deleteFromCart(snapshot.data![index].id);
                                cart.removeCounter();
                                cart.removeTotalPrice(double.parse(snapshot.data![index].productPrice.toString()));

                              },
                              child: const Text("Remove",
                                style: TextStyle(
                                    color: Colors.black54
                                ),
                              ),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                  onPressed: (){
                                    int quantity= int.parse(snapshot.data![index].quantity);
                                    int price= int.parse(snapshot.data![index].initialPrice);
                                    quantity--;
                                    int? newPrice= price*quantity;

                                    if(quantity!=0){
                                      db!.updateQuantity(
                                          Cart(
                                              id: snapshot.data![index].id,
                                              productId: snapshot.data![index].productId,
                                              productName: snapshot.data![index].productName,
                                              initialPrice: snapshot.data![index].initialPrice,
                                              productPrice: newPrice.toString(),
                                              quantity: quantity.toString(),
                                              unitTag: snapshot.data![index].unitTag,
                                              image: snapshot.data![index].image,
                                              productType: snapshot.data![index].productType
                                          )
                                      ).then((value){
                                        newPrice= 0;
                                        quantity= 0;
                                        cart.removeTotalPrice(double.parse(snapshot.data![index].initialPrice.toString()));

                                      }).catchError((onError){
                                        debugPrint(onError.toString());
                                      });
                                    }
                                  },
                                  icon: const Icon(Icons.remove_circle_outline_rounded),
                                ),

                                Text(snapshot.data![index].quantity.toString(),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),

                                IconButton(
                                  onPressed: (){
                                    int quantity= int.parse(snapshot.data![index].quantity);
                                    int price= int.parse(snapshot.data![index].initialPrice);
                                    quantity++;
                                    int? newPrice= price*quantity;

                                    db!.updateQuantity(
                                        Cart(
                                            id: snapshot.data![index].id,
                                            productId: snapshot.data![index].productId,
                                            productName: snapshot.data![index].productName,
                                            initialPrice: snapshot.data![index].initialPrice,
                                            productPrice: newPrice.toString(),
                                            quantity: quantity.toString(),
                                            unitTag: snapshot.data![index].unitTag,
                                            image: snapshot.data![index].image,
                                            productType: snapshot.data![index].productType
                                        )
                                    ).then((value){
                                      newPrice= 0;
                                      quantity= 0;
                                      cart.addTotalPrice(double.parse(snapshot.data![index].initialPrice.toString()));

                                    }).catchError((onError){
                                      debugPrint(onError.toString());
                                    });
                                  },
                                  icon: const Icon(Icons.add_circle_outline_rounded),
                                ),
                              ],
                            )

                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
          else if (snapshot.hasError) {
            return Text('Error2: ${snapshot.error}');
          }
          else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }
    );
  }
}

class ReusableWidget extends StatelessWidget{
  final String title, value;
  const ReusableWidget({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          title,
          style: const TextStyle(
            // fontSize: 25,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.3
          ),
        ),

        Text(
          value.toString(),
            style: const TextStyle(
                // fontSize: 22
            ),
        ),
      ],
    );
  }
}
