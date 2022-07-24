import 'package:consultation/layout/cubit/states.dart';
import 'package:consultation/modules/balance/balance.dart';
import 'package:consultation/modules/chat/chat.dart';
import 'package:consultation/modules/home/home.dart';
import 'package:consultation/modules/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  Text('الدردشات'),
  Text('الملف الشخصي'),
  Text('رصيد الحساب')
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

}