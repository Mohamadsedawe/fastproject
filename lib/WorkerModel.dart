
class WorkerResponse {
  List<Workers>? workers;

  WorkerResponse({this.workers});

  WorkerResponse.fromJson(Map<String, dynamic> json) {
    if (json['workers'] != null) {
      workers = <Workers>[];
      json['workers'].forEach((v) {
        workers!.add(Workers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.workers != null) {
      data['workers'] = this.workers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Workers {
  int? id;
  String? firstname;
  String? lastname;
  String? role;
  String? adminKey;
  String? address;
  String? phoneNumber;
  String? email;
  dynamic emailVerifiedAt;
  bool? isBanned;
  String? createdAt;
  String? updatedAt;

  Workers({
    this.id,
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
    this.updatedAt,
  });

  Workers.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = {};
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
