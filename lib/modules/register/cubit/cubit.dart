import 'dart:io';

import 'package:consultation/modules/register/cubit/states.dart';
import 'package:consultation/shared/components/components.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

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
       'image':'assets/images/consultation_icon/cat1.png',
       'name':'استشارة قانونية'
     },
     {
       'image':'assets/images/consultation_icon/cat2.png',
       'name':'استشارة معمارية'
     },
     {
       'image':'assets/images/consultation_icon/cat3.png',
       'name':'استشارة رجل اعمال'
     },
     {
       'image':'assets/images/consultation_icon/cat4.png',
       'name':'استشارة نفسية'
     },
     {
       'image':'assets/images/consultation_icon/cat5.png',
       'name':'استشارة اسرية'
     },
     {
       'image':'assets/images/consultation_icon/cat7.png',
       'name':'استشارة شعر وجمال'
     },
     {
       'image':'assets/images/consultation_icon/cat8.png',
       'name':'استشارة تغذية'
     },
     {
       'image':'assets/images/consultation_icon/cat9.png',
       'name':'استشارة برميجة'
     },
  ];
  String? selectedValue;

void changeSelected(value){
  selectedValue = value ;
  emit(RegesterChangeSelectedState());
}


  File? profileimage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileimage = File(pickedFile.path);
      print('==.>$profileimage');
      emit(RegesterImagePickedSuccsessState());
    } else {
      print('no image selected');
      emit(RegesterImagePickedErrorState());
    }
  }

  _uploadImage() async{
    var formData= FormData.fromMap({
      "image" : await MultipartFile.fromFile(profileimage!.path)
    });
  }
}