class Register_Model_C {
  SavedUser? savedUser;
  bool? status;
  String? message;

  Register_Model_C({this.savedUser, this.status});

  Register_Model_C.fromJson(Map<String, dynamic> json) {
    savedUser = json['savedUser'] != null
        ? new SavedUser.fromJson(json['savedUser'])
        : null;
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.savedUser != null) {
      data['savedUser'] = this.savedUser!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class SavedUser {
  String? profilePicture;
  String? cVPhoto;
  String? Id;
  String? username;
  String? FCM_TOKEN;
  String? email;
  String? password;
  String? createdAt;
  String? updatedAt;
  int? iV;

  SavedUser(
      {this.profilePicture,
        this.cVPhoto,
        this.Id,
        this.username,
        this.FCM_TOKEN,
        this.email,
        this.password,
        this.createdAt,
        this.updatedAt,
        this.iV});

  SavedUser.fromJson(Map<String, dynamic> json) {
    profilePicture = json['photo'];
    cVPhoto = json['file'];
    FCM_TOKEN = json['FCM_TOKEN'];
    Id = json['_id'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['photo'] = this.profilePicture;
    data['CVPhoto'] = this.cVPhoto;
    data['_id'] = this.Id;
    data['FCM_TOKEN'] = this.FCM_TOKEN;
    data['username'] = this.username;
    data['email'] = this.email;
    data['password'] = this.password;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
