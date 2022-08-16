import 'package:consultation/models/LoginC_Model.dart';
import 'package:consultation/modules/login/login_screan.dart';
import 'package:consultation/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:consultation/shared/network/local/cash_helper.dart';
String? token = '';
String? tokenU = '';
String? ID = '';

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


bool IsValidEmail(String email) {
  return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(email);
}

Widget SignOut({required context}) =>
    defultTextButtton(text: 'SignOut', function: () {
      cash_helper.removeData(key: 'token').then((value) {
        navigateToAndFinish(context, Login_Screan());
      });
    });