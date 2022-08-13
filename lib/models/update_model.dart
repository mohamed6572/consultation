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
  String? email;
  String? password;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? about;
  String? qualification;
  String? counseling;
  String? country;
  double? price;
  double? rating;
  String? duration;
  int? phone;

  UpdatedUser(
      {this.profilePicture,
        this.cVPhoto,
        this.Id,
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
        this.phone});

  UpdatedUser.fromJson(Map<String, dynamic> json) {
    profilePicture = json['profilePicture'];
    cVPhoto = json['CVPhoto'];
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
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profilePicture'] = this.profilePicture;
    data['CVPhoto'] = this.cVPhoto;
    data['_id'] = this.Id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['rating'] = this.rating;
    data['price'] = this.price;
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
