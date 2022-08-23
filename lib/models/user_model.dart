class User_Model {
  Others? others;
  bool? status;

  User_Model({this.others, this.status});

  User_Model.fromJson(Map<String, dynamic> json) {
    others =
    json['others'] != null ? new Others.fromJson(json['others']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.others != null) {
      data['others'] = this.others!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Others {
  String? sId;
  String? username;
  String? email;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Others(
      {this.sId,
        this.username,
        this.email,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Others.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
    email = json['email'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['username'] = this.username;
    data['email'] = this.email;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
