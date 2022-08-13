class Login_Model {
  bool? isAdmin;
  String? Id;
  String? username;
  String? email;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? accessToken;

  Login_Model(
      {this.isAdmin,
        this.Id,
        this.username,
        this.email,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.accessToken});

  Login_Model.fromJson(Map<String, dynamic> json) {
    isAdmin = json['isAdmin'];
    Id = json['_id'];
    username = json['username'];
    email = json['email'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    accessToken = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isAdmin'] = this.isAdmin;
    data['_id'] = this.Id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['accessToken'] = this.accessToken;
    return data;
  }
}
