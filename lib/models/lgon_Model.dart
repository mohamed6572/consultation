class Login_Model {
  String? Id;
  String? username;
  String? email;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? accessToken;
  String? message;
  bool? status;

  Login_Model(
      {
        this.Id,
        this.message,
        this.username,
        this.email,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.status,
        this.accessToken});

  Login_Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    Id = json['_id'];
    message = json['message'];
    username = json['username'];
    email = json['email'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    accessToken = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.Id;
    data['message'] = this.message;
    data['status'] = this.status;
    data['username'] = this.username;
    data['email'] = this.email;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['accessToken'] = this.accessToken;
    return data;
  }
}
