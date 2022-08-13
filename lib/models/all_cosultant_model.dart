class all_consultant_model {
  List<Consultants>? consultants;
  bool? status;

  all_consultant_model({this.consultants, this.status});

  all_consultant_model.fromJson(Map<String, dynamic> json) {
    if (json['consultants'] != null) {
      consultants = <Consultants>[];
      json['consultants'].forEach((v) {
        consultants!.add(new Consultants.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.consultants != null) {
      data['consultants'] = this.consultants!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Consultants {
  String? profilePicture;
  String? cVPhoto;
  String? sId;
  int? rating;
  String? price;
  String? username;
  String? email;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? about;
  String? qualification;
  String? counseling;
  String? country;
  String? duration;
  int? phone;
  String? accessToken;

  Consultants(
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
        this.duration,
        this.phone,
        this.accessToken,
        });

  Consultants.fromJson(Map<String, dynamic> json) {
    profilePicture = json['profilePicture'];
    cVPhoto = json['CVPhoto'];
    sId = json['_id'];
    username = json['username'];
    email = json['email'];
    price = json['price'];
    rating = json['rating'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    about = json['About'];
    qualification = json['Qualification'];
    counseling = json['counseling'];
    country = json['country'];
    duration = json['duration'];
    phone = json['phone'];
    accessToken = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profilePicture'] = this.profilePicture;
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
    data['accessToken'] = this.accessToken;
    return data;
  }
}
