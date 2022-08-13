class all_users {
  List<Users>? users;
  bool? status;

  all_users({this.users, this.status});

  all_users.fromJson(Map<String, dynamic> json) {
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Users {
  String? sId;
  bool? confirmed;
  String? username;
  String? email;
  String? password;
  String? createdAt;
  String? updatedAt;
  int? iV;
  bool? isAdmin;

  Users(
      {this.sId,
        this.confirmed,
        this.username,
        this.email,
        this.password,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.isAdmin});

  Users.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    confirmed = json['confirmed'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    isAdmin = json['isAdmin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['confirmed'] = this.confirmed;
    data['username'] = this.username;
    data['email'] = this.email;
    data['password'] = this.password;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['isAdmin'] = this.isAdmin;
    return data;
  }
}
