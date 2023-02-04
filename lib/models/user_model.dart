class User_Model{

  String? name;
  String? email;
  String? image;
  String? password;
  String? uid;

  User_Model({
    this.email,
    this.image,
    this.name,
    this.uid,
    this.password
  });

  User_Model.fromJson(Map<String,dynamic> json){
    name = json['name'];
    email = json['email'];
    image = json['image'];
    password = json['password'];
    uid = json['uid'];
  }

  Map<String,dynamic> toMap(){
    return {
      'name' : name,
      'uid' : uid,
      'email' : email,
      'password' : password,
      'image' : image,
    };
  }
}