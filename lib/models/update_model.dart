class Update_Model {
  UpdatedUser? updatedUser;
  bool? status;

  Update_Model({this.updatedUser, this.status});

  Update_Model.fromJson(Map<String, dynamic> json) {
    updatedUser = json['updatedUser'] != null
        ? new UpdatedUser.fromJson(json['updatedUser'])
        : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.updatedUser != null) {
      data['updatedUser'] = this.updatedUser!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class UpdatedUser {
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
  String? about;
  String? qualification;
  String? counseling;
  String? country;
  String? balance;
  String? price;
  int? rating;
  String? duration;
  int? phone;

  UpdatedUser(
      {this.profilePicture,
        this.cVPhoto,
        this.Id,
        this.FCM_TOKEN,
        this.price,
        this.rating,
        this.username,
        this.email,
        this.password,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.about,
        this.qualification,
        this.counseling,
        this.country,
        this.duration,
        this.balance,
        this.phone});

  UpdatedUser.fromJson(Map<String, dynamic> json) {
    profilePicture = json['photo'];
    cVPhoto = json['file'];
    FCM_TOKEN = json['FCM_TOKEN'];
    Id = json['_id'];
    username = json['username'];
    price = json['price'];
    rating = json['rating'];
    email = json['email'];
    password = json['password'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    about = json['About'];
    qualification = json['Qualification'];
    counseling = json['counseling'];
    country = json['country'];
    duration = json['duration'];
    balance = json['balance'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['photo'] = this.profilePicture;
    data['CVPhoto'] = this.cVPhoto;
    data['_id'] = this.Id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['balance'] = this.balance;
    data['rating'] = this.rating;
    data['price'] = this.price;
    data['FCM_TOKEN'] = this.FCM_TOKEN;
    data['password'] = this.password;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['About'] = this.about;
    data['Qualification'] = this.qualification;
    data['counseling'] = this.counseling;
    data['country'] = this.country;
    data['duration'] = this.duration;
    data['phone'] = this.phone;
    return data;
  }
}
