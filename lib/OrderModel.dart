class Orderi {
  List<Order>? orderss;

  Orderi({this.orderss});
  factory Orderi.fromJson(Map<String, dynamic> json) {
    return Orderi(
      orderss: json['orders'] != null
          ? List<Order>.from(json['orders'].map((x) => Order.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orders': orderss != null
          ? List<dynamic>.from(orderss!.map((x) => x.toJson()))
          : null,
    };
  }
}

class Order {
  int? id;
  String? itemName;
  int? itemId;
  int? userId;
  String? details;

  Order({
    this.id,
    this.itemName,
    this.itemId,
    this.userId,
    this.details,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      itemName: json['item_name'],
      itemId: json['item_id'],
      userId: json['user_id'],
      details: json['details'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'item_name': itemName,
      'item_id': itemId,
      'user_id': userId,
      'details': details,
    };
  }
}