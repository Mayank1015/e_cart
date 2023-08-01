class Cart{
  String id;
  String productId;
  String productName;
  String initialPrice;
  String productPrice;
  String quantity;
  String unitTag;
  String image;
  String productType;

  Cart({
    required this.id,
    required this.productId,
    required this.productName,
    required this.initialPrice,
    required this.productPrice,
    required this.quantity,
    required this.unitTag,
    required this.image,
    required this.productType
  });

  Cart.fromMap(Map<dynamic, dynamic> res):
        id= res['id'],
        productId= res['productId'],
        productName= res['productName'],
        initialPrice= res['initialPrice'],
        productPrice= res['productPrice'],
        quantity= res['quantity'],
        unitTag= res['unitTag'],
        image= res['image'],
        productType= res['productType'];

  Map<String, Object?> toMap(){
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'initialPrice': initialPrice,
      'productPrice': productPrice,
      'quantity': quantity,
      'unitTag': unitTag,
      'image': image,
      'productType': productType,
    };
  }
}