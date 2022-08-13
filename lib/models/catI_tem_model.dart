import 'package:flutter/material.dart';

class catItem_model{
  String image;
  Color? color;
  String text;
  catItem_model({required this.image,required this.color ,required this.text});
}

class catItem_details_model{
  String? image;
  String? details;
  String? name;
  String? pay;
  String? star;

  catItem_details_model({required this.image,required this.details ,required this.pay  ,required this.star ,required this.name});

  catItem_details_model.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    details = json['details'];
    name = json['name'];
    pay = json['pay'];
    star = json['star'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['details'] = this.details;
    data['name'] = this.name;
    data['pay'] = this.pay;
    data['star'] = this.star;
    return data;
  }
}
