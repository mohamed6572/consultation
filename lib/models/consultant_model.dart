
class Consultant_Model {
  String? profilePicture;
  String? cVPhoto;
  String? sId;
  int? rating;
  String? price;
  String? balance;
  String? username;
  String? email;
  String? FCM_TOKEN;
  String? about;
  String? qualification;
  String? counseling;
  String? country;
  int? EX;
  String? phone;
  String? password;

  Consultant_Model(
      {this.profilePicture,
        this.cVPhoto,
        this.sId,
        this.password,
        this.balance,
        this.username,
        this.email,

        this.rating,
        this.price,

        this.about,
        this.qualification,
        this.counseling,
        this.country,
        this.FCM_TOKEN,
        this.EX,
        this.phone,
      });

  Consultant_Model.fromJson(Map<String, dynamic> json) {
    profilePicture = json['image'];
    password = json['password'];
    cVPhoto = json['CVPhoto'];
    sId = json['uid'];
    balance = json['balance'];
    username = json['name'];
    email = json['email'];
    price = json['price'];
    rating = json['rating'];

    FCM_TOKEN = json['FCM_TOKEN'];

    about = json['About'];
    qualification = json['Qualification'];
    counseling = json['counseling'];
    country = json['country'];
    EX = json['duration'];
    phone = json['phone'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.profilePicture;
    data['password'] = this.password;
    data['balance'] = this.balance;
    data['FCM_TOKEN'] = this.FCM_TOKEN;
    data['CVPhoto'] = this.cVPhoto;
    data['uid'] = this.sId;
    data['rating'] = this.rating;
    data['price'] = this.price;
    data['name'] = this.username;
    data['email'] = this.email;
    data['About'] = this.about;
    data['Qualification'] = this.qualification;
    data['counseling'] = this.counseling;
    data['country'] = this.country;
    data['duration'] = this.EX;
    data['phone'] = this.phone;
    return data;
  }
}
