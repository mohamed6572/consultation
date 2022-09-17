class visa_Model {
  List<String>? message;
  bool? status;


  visa_Model({this.message, this.status});

  visa_Model.fromJson(Map<String, dynamic> json) {
    message = json['message'].cast<String>();
    status = json['status'];

  }
}

