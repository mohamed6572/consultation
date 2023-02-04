import 'package:flutter/material.dart';

import 'all_cosultant_model.dart';
import 'consultant_model.dart';

class catItem_model{
  String image;
  Color? color;
  String text;
  List<Consultant_Model> list;
  catItem_model({required this.image,required this.color ,required this.text,required this.list});
}
