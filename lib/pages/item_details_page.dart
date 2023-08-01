import 'package:e_cart/models/item_model.dart';
import 'package:flutter/material.dart';

class ItemDetails extends StatefulWidget {
  final ItemModel data;
  const ItemDetails({Key? key, required this.data}) : super(key: key);

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        leadingWidth: 70,
        leading: IconButton(
          onPressed: (){Navigator.pop(context);},
          icon: const Icon(Icons.keyboard_backspace_rounded),
        ),

        title: const Text("Product Details",
          style: TextStyle(
            letterSpacing: 0.3
          ),
        ),
        centerTitle: true,

      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(widget.data.imgLink, height: 300),

              const SizedBox(height: 15,),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.data.name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                              letterSpacing: 0.5
                          ),
                        ),

                        Text("Rs ${widget.data.price}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5
                          ),
                        ),
                      ],
                    ),
                    Text(widget.data.itemType,
                      style: const TextStyle(color: Colors.black54),
                    ),

                    const SizedBox(height: 20,),

                    const Text("About",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.3
                      ),
                    ),

                    const SizedBox(height: 5,),

                    Text(widget.data.desc, textAlign: TextAlign.justify,
                      style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 15,
                          letterSpacing: 0.2,
                          // fontWeight: FontWeight.bold
                      ),
                    ),

                    const SizedBox(height: 20,),
                    
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: InkWell(
          child: Container(
            width: MediaQuery.of(context).size.width-15,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text("Buy Now",
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
