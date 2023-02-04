import 'package:consultation/models/LoginC_Model.dart';
import 'package:consultation/modules/login/login_screan.dart';
import 'package:consultation/shared/components/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:consultation/shared/network/local/cash_helper.dart';

import '../../models/consultant_model.dart';
import '../../models/notification_model.dart';
import '../../models/user_model.dart';
String? token = '';
String? tokenU = '';
String? ID = '';
String? UserID = '';
// Map<String,dynamic> notefications= {};
Notification_Model? notefications;
List<Notification_Model> notication =[];
Widget itemregister(text) =>  Padding(
  padding: const EdgeInsets.only(right: 8.0,bottom: 9),
  child: Text(
    text,
    style: TextStyle(
      fontSize: 16,
    ),
    textAlign: TextAlign.end,
  ),
);

Consultant_Model? model;
bool IsValidEmail(String email) {
  return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(email);
}

// Widget SignOut({required context}) =>
//     defultTextButtton(text: 'SignOut', function: () {
//       cash_helper.removeData(key: 'token').then((value) {
//         navigateToAndFinish(context, Login_Screan());
//       });
//     });