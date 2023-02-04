class Message_Model {

  List<String>? messege=[];
  // String? senderId;
  // String? receiverId;
  // String? dateTime;


  Message_Model({
    this.messege,
    // this.senderId,
    // this.receiverId,
    // this.dateTime,


  });

  Message_Model.fromJson(Map<String, dynamic> json) {

    json['messege'].forEach((element) {
      messege?.add(element);
    });

  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['messege'] = this.messege?.map((e) => e).toList();
    return data;
  }

}
// class TText{
//   String? text;
//   // String? senderId;
//   // String? receiverId;
//   // String? dateTime;
//
//
//   TText({
//     this.text,
//     // this.senderId,
//     // this.receiverId,
//     // this.dateTime,
//
//
//   });
//
//   TText.fromJson(Map<String, dynamic> json) {
//
//     text = json['text'];
//
//   }
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['messege'] = this.messege?.map((e) => e).toList();
//     return data;
//   }
// }