import 'package:consultation/modules/register/cubit/states.dart';
import 'package:consultation/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegesterCubit extends Cubit<RegesterStates>{
  RegesterCubit(): super(RegesterInitialeState());

  static RegesterCubit get(context) => BlocProvider.of(context);


  IconData suffix = Icons.visibility;
  bool isPasword = true;
  bool isUser = true;

  void changePasswordVisability(){
    isPasword = !isPasword;
    suffix = isPasword ? Icons.visibility : Icons.visibility_off;
    emit(RegesterChangePasswordState());

  }
  void changeUserRegister(){
    isUser = !isUser;
    emit(RegesterChangeregisterState());

  }

   List<Map> items = [
     {
       'image':'assets/images/consultation/cat1.png',
       'name':'cat1'
     },
     {
       'image':'assets/images/consultation/cat2.png',
       'name':'cat2'
     },
     {
       'image':'assets/images/consultation/cat3.png',
       'name':'cat3'
     },
     {
       'image':'assets/images/consultation/cat4.png',
       'name':'cat4'
     },
     {
       'image':'assets/images/consultation/cat5.png',
       'name':'cat5'
     },
     {
       'image':'assets/images/consultation/cat6.png',
       'name':'cat6'
     },
     {
       'image':'assets/images/consultation/cat7.png',
       'name':'cat7'
     },
     {
       'image':'assets/images/consultation/cat8.png',
       'name':'cat8'
     },
     {
       'image':'assets/images/consultation/cat9.png',
       'name':'cat9'
     },
  ];
  String? selectedValue;

void changeSelected(value){
  selectedValue = value ;
  emit(RegesterChangeSelectedState());
}
}