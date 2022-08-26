class Consultant_Model {
  Others? others;
  bool? status;

  Consultant_Model({this.others, this.status});

  Consultant_Model.fromJson(Map<String, dynamic> json) {
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
  String? profilePicture;
  String? cVPhoto;
  String? sId;
  int? rating;
  String? price;
  String? username;
  String? email;
  String? createdAt;
  String? updatedAt;
  String? FCM_TOKEN;
  int? iV;
  String? about;
  String? qualification;
  String? counseling;
  String? country;
  String? duration;
  int? phone;

  Others(
      {this.profilePicture,
        this.cVPhoto,
        this.sId,
        this.username,
        this.email,
        this.createdAt,
        this.rating,
        this.price,
        this.updatedAt,
        this.iV,
        this.about,
        this.qualification,
        this.counseling,
        this.country,
        this.FCM_TOKEN,
        this.duration,
        this.phone,
      });

  Others.fromJson(Map<String, dynamic> json) {
    profilePicture = json['photo'];
    cVPhoto = json['file'];
    sId = json['_id'];
    username = json['username'];
    email = json['email'];
    price = json['price'];
    rating = json['rating'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    FCM_TOKEN = json['FCM_TOKEN'];
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
    data['photo'] = this.profilePicture;
    data['FCM_TOKEN'] = this.FCM_TOKEN;
    data['CVPhoto'] = this.cVPhoto;
    data['_id'] = this.sId;
    data['rating'] = this.rating;
    data['price'] = this.price;
    data['username'] = this.username;
    data['email'] = this.email;
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
