class Notification_Model{

String?  type;
String?   id;
String?   name;
String?   text;
String?  image;
String?  click_action;

Notification_Model.fromJson(Map<String, dynamic> json) {

  text = json['text'];
  image = json['image'];
  type = json['type'];
  id = json['id'];
  name = json['name'];
  click_action = json['click_action'];

}
}