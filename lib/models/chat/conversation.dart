
class Conversation {
  Sender? sender;
  Reciver? reciver;
  String? Id;
  String? createdAt;


  Conversation(
      {this.sender, this.Id, this.createdAt, this.reciver

      });

  Conversation.fromJson(Map<String, dynamic> json) {
    sender = Sender.fromJson(json['sender']);
    reciver = Reciver.fromJson(json['reciver']);
    Id = json['id'];
    createdAt = json['createdAt'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sender'] = this.sender?.toJson();
    data['id'] = this.Id;
    data['createdAt'] = this.createdAt;
    data['reciver'] = this.reciver?.toJson();

    return data;
  }
}
class Sender {
  String? SenderID;
  String? Image;
  String? Name;


  Sender(
      {this.SenderID, this.Image, this.Name});
  Sender.fromJson(Map<String, dynamic> json) {
    SenderID = json['SenderID'];
    Image = json['Image'];
    Name = json['Name'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SenderID'] = this.SenderID;
    data['Image'] = this.Image;
    data['Name'] = this.Name;

    return data;
  }
}
class Reciver {
  String? reciverID;
  String? Image;
  String? Name;


  Reciver(
      {this.reciverID, this.Image, this.Name});
  Reciver.fromJson(Map<String, dynamic> json) {
    reciverID = json['reciverID'];
    Image = json['Image'];
    Name = json['Name'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reciverID'] = this.reciverID;
    data['Image'] = this.Image;
    data['Name'] = this.Name;
    return data;
  }
}
