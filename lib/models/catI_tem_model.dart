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
}
