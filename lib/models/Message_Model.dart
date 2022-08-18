class MessageModel {
  String? text;
  String? image;
  String? senderId;
  String? receiverId;
  String? dateTime;


  MessageModel({
    this.text,
    this.image,
    this.senderId,
    this.receiverId,
    this.dateTime,


  });

  MessageModel.fromJson(Map<String, dynamic> json) {

    text = json['text'];
    image = json['image'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];

  }

  Map<String, dynamic> toJson(){
    return {
      'text': text,
      'image': image,
      'senderId': senderId,
      'receiverId': receiverId,
      'dateTime': dateTime,


    };
  }
}