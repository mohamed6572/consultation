import 'dart:convert';

import 'package:consultation/layout/cubit/states.dart';
import 'package:consultation/modules/balance/balance.dart';
import 'package:consultation/modules/chat/chat.dart';
import 'package:consultation/modules/home/home.dart';
import 'package:consultation/modules/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;


class AppCubit extends Cubit<AppStates>{

  AppCubit():super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

List<Widget> screans=[
Home_Screan(),
  Chat_Screan(),
  Profile_Screan(),
  Balance_Screan()
];
List<Widget> titles=[
  Column(
    children: [
      SizedBox(
        height: 10,
      ),
      Image(
        image: AssetImage('assets/images/logo.png'),
        height: 50,
      ),
    ],
  ),
  Text('الدردشات',style: TextStyle(fontWeight: FontWeight.w500),),
  Text('الملف الشخصي',style: TextStyle(fontWeight: FontWeight.w500),),
  Text('رصيد الحساب',style: TextStyle(fontWeight: FontWeight.w500),)
];
List<BottomNavigationBarItem> botItems=[
  BottomNavigationBarItem(icon: Icon(Icons.home_filled),label: 'الرئيسية'),
  BottomNavigationBarItem(icon: Icon(Icons.message),label: 'الدردشة'),
  BottomNavigationBarItem(icon: Icon(Icons.person),label: 'الملف الشخصي'),
  BottomNavigationBarItem(icon: Icon(Icons.attach_money),label: 'الرصيد'),
];

int currentIndex =0;

void ChangeBotomIndex(index){
  currentIndex= index;
  emit(AppchangeBotBarState());
}

double rating=0;
void RatingApp(rat){
  rating = rat;
  emit(AppRatingState());
}

Future sendEmailComplaint({
  required String email,
  required String opnion,
  required String complaint,
})async{

// final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
// final response = await http.post(
//   url,
//  headers: {
//     'origin': 'http://localhost',
//    'contentType': 'application/json',
//  },
//  body: json.encode( {
//     'service_id':'service_oibints',
//     'template_id':'template_6dpv03p',
//     'user_id':'HFyf4BbHpnW_kpDC',
//    'template_params': {
//      'user_email': email,
//      'user_message': complaint,
//      'user_opinion': opnion
//    }
//  })
// ).then((value) {
//   emit(AppSendSucssesState());
// }).catchError((e){
//   emit(AppSendErrorState());
// });
  const serviceId = 'service_oibints';    //serviceId from emailjs
  const templateId = 'template_6dpv03p';  //your templateId from emailjs
  const userId = 'HFyf4BbHpnW_kpDC-';     //your Public Key from emailjs
  final url = Uri.parse(
      'https://api.emailjs.com/api/v1.0/email/send-form');
  final response = await http.post(url, body: {
    'service_id': serviceId,
    'template_id': templateId,
    'user_id': userId,
    'accessToken': '15yju4YQPzN1tEIeWiglA',   //your Private Key from emailjs
    'user_email': email,
    'user_message': complaint,
    'user_opinion': opnion

  },

 headers: {
     'origin': 'http://localhost',
    'contentType': 'application/json',
  },
  );
print(response.body);
}



}