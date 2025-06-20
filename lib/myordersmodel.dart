class myorder {
  String? message;
  List<Orders>? orders;

  myorder({this.message, this.orders});

  myorder.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(new Orders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.orders != null) {
      data['orders'] = this.orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Orders {
  int? id;
  String? itemName;
  int? itemId;
  int? userId;
  String? details;
  String? status;
  int? workerId;
  String? createdAt;
  String? updatedAt;
  User? user;
  Item? item;

  Orders(
      {this.id,
        this.itemName,
        this.itemId,
        this.userId,
        this.details,
        this.status,
        this.workerId,
        this.createdAt,
        this.updatedAt,
        this.user,
        this.item});

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemName = json['item_name'];
    itemId = json['item_id'];
    userId = json['user_id'];
    details = json['details'];
    status = json['status'];
    workerId = json['worker_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    item = json['item'] != null ? new Item.fromJson(json['item']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item_name'] = this.itemName;
    data['item_id'] = this.itemId;
    data['user_id'] = this.userId;
    data['details'] = this.details;
    data['status'] = this.status;
    data['worker_id'] = this.workerId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.item != null) {
      data['item'] = this.item!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? firstname;
  String? lastname;
  String? role;
  Null? adminKey;
  String? address;
  String? phoneNumber;
  String? email;
  Null? emailVerifiedAt;
  bool? isBanned;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
        this.firstname,
        this.lastname,
        this.role,
        this.adminKey,
        this.address,
        this.phoneNumber,
        this.email,
        this.emailVerifiedAt,
        this.isBanned,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    role = json['role'];
    adminKey = json['admin_key'];
    address = json['address'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    isBanned = json['is_banned'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['role'] = this.role;
    data['admin_key'] = this.adminKey;
    data['address'] = this.address;
    data['phone_number'] = this.phoneNumber;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['is_banned'] = this.isBanned;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Item {
  int? id;
  String? name;
  int? categoryId;
  Null? workerId;
  String? createdAt;
  String? updatedAt;

  Item(
      {this.id,
        this.name,
        this.categoryId,
        this.workerId,
        this.createdAt,
        this.updatedAt});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryId = json['category_id'];
    workerId = json['worker_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['category_id'] = this.categoryId;
    data['worker_id'] = this.workerId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}