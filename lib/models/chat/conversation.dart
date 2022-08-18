import '../all_cosultant_model.dart';

class Conversation {
  List<String>? members;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Conversation(
      {this.members, this.sId, this.createdAt, this.updatedAt, this.iV});

  Conversation.fromJson(Map<String, dynamic> json) {
    members = json['members'].cast<String>();
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['members'] = this.members;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
class list {
  Consultants? consultants;
  String? ID;

  list(
      {this.consultants, this.ID});

}
