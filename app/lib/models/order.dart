

import 'package:app/models/database_item.dart';

class Order extends DatabaseItem {
  Order({
    this.id,
    this.deliveryAddress,
    this.emailAddress,
    this.mobileNumber,
    this.orderDate,
    this.orderState,
    this.orderedItems,
    this.totalAmount,
    this.userId,
    this.coupon,
    this.specialNote,
    this.deviceLocation
  }) : super(id);

  final String id;
  final String deliveryAddress;
  final String emailAddress;
  final int mobileNumber;
  final DateTime orderDate;
  final String orderState;
  final List<OrderedItem> orderedItems;
  final int totalAmount;
  final String userId;
  final String coupon;
  final String specialNote;
  final String deviceLocation;

  factory Order.fromDS(String id,Map<String, dynamic> json) => Order(
        id: id,
        deliveryAddress: json["deliveryAddress"],
        emailAddress: json["emailAddress"],
        mobileNumber: json["mobileNumber"],
        orderDate: json["orderDate"]?.toDate(),
        orderState: json["orderState"],
        orderedItems: List<OrderedItem>.from(
            json["orderedItems"].map((x) => OrderedItem.fromMap(x))),
        totalAmount: json["totalAmount"],
        userId: json["userId"],
        coupon: json["coupon"],
        specialNote: json["specialNote"],
        deviceLocation: json["deviceLocation"],
      );

  Map<String, dynamic> toMap() => {
        "deliveryAddress": deliveryAddress,
        "emailAddress": emailAddress,
        "mobileNumber": mobileNumber,
        "orderDate": orderDate,
        "orderState": orderState,
        "orderedItems": List<dynamic>.from(orderedItems.map((x) => x.toMap())),
        "totalAmount": totalAmount,
        "userId": userId,
        "coupon":coupon,
        "specialNote":specialNote,
        "deviceLocation":deviceLocation,
      };
}

class OrderedItem {
  OrderedItem({
    this.imageUrl,
    this.name,
    this.price,
    this.productId,
    this.quantity,
  });

  final String imageUrl;
  final String name;
  final int price;
  final String productId;
  final int quantity;

  factory OrderedItem.fromMap(Map<String, dynamic> json) => OrderedItem(
        imageUrl: json["imageUrl"],
        name: json["name"],
        price: json["price"],
        productId: json["productId"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toMap() => {
        "imageUrl": imageUrl,
        "name": name,
        "price": price,
        "productId": productId,
        "quantity": quantity,
      };
}
