import 'dart:convert';
import 'dart:io';

import 'package:consultation/layout/cubit/states.dart';
import 'package:consultation/models/all_cosultant_model.dart';
import 'package:consultation/models/consultant_model.dart';
import 'package:consultation/models/update_model.dart';
import 'package:consultation/modules/balance/balance.dart';
import 'package:consultation/modules/chat/chat.dart';
import 'package:consultation/modules/home/home.dart';
import 'package:consultation/modules/profile/profile.dart';
import 'package:consultation/shared/components/constens.dart';
import 'package:consultation/shared/network/end_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../models/LoginC_Model.dart';
import '../../models/catI_tem_model.dart';
import '../../shared/network/remote/dio_helper.dart';


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

List<BottomNavigationBarItem> botItemsU=[
  BottomNavigationBarItem(icon: Icon(Icons.home_filled),label: 'الرئيسية'),
  BottomNavigationBarItem(icon: Icon(Icons.message),label: 'الدردشة'),
];

int currentIndex =0;

void ChangeBotomIndex(index){
  currentIndex= index;
  emit(AppchangeBotBarState());
}
///rating
double rating=0;
void RatingApp(rat){
  rating = rat;
  emit(AppRatingState());
}
///send email complaint
Future sendEmailComplaint({
  required String email,
  required String opnion,
  required String complaint,
})async{

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

  File? editprofileimage;
  var picker = ImagePicker();

  Future<void> getEditProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      editprofileimage = File(pickedFile.path);
      print('==.>$editprofileimage');
      emit(EditImagePickedSuccsessState());
    } else {
      print('no image selected');
      emit(EditImagePickedErrorState());
    }
  }


  Update_Model? update_Consultant_model;
  //edit profile
  void UpdateConsaltant({
    String? profilePicture,
    String? About,
    String? country,
    String? phone,
    String? price,
  }){
    emit(UpdateLodingState());

    Dio_Helper.putData(url: UPDATEC+ID!, data: {
      "profilePicture":profilePicture,
      "About":About,
      "price":price,
      "country":country,
      "phone":phone,
    },).then((value) {
      print("$UPDATEC+'$ID'");
      update_Consultant_model = Update_Model.fromJson(value.data);
      emit(UpdateSuccsessState());
    }).catchError((e){
      print(e.toString());
      emit(UpdateErrorState());
    });


  }

  Consultant_Model? usermodel;
//get consltant data
  void GetConsaltant(){
    print("$GetC'$ID'+$token");
    emit(getCLodingState());
    Dio_Helper.getData(url: GetC+ID!,token: token).then((value) {
      usermodel = Consultant_Model.fromJson(value.data);
      print(usermodel?.others?.username);
      print("$GetC+'$ID'+$token");
      emit(getCSuccsessState());
    }).catchError((e){
      print(e.toString());
      emit(getCErrorState());
    });
  }

  //get all consultant
  all_consultant_model? consultant_model_for_loist;
  List<Consultants> law =[];
  List<Consultants> engeier =[];
  List<Consultants> man =[];
  List<Consultants> relashin =[];
  List<Consultants> family =[];
  List<Consultants> hear =[];
  List<Consultants> health =[];
  List<Consultants> programing =[];
  void GetAllConsaltant(){
    law =[];
    engeier =[];
    man =[];
    relashin =[];
    family =[];
    hear =[];
    health =[];
    programing =[];

    emit(getAllCLodingState());
    Dio_Helper.getData(url: GetAllC,token: token).then((value) {
      consultant_model_for_loist = all_consultant_model.fromJson(value.data);
      consultant_model_for_loist?.consultants?.forEach((element) {
        if(element.counseling == 'استشارة قانونية')
            law.add(element);

        print(law.length);
        if(element.counseling == 'استشارة معمارية')
            engeier.add(element);

        print(engeier.length);

        if(element.counseling == 'استشارة رجل اعمال')
            man.add(element);

        print(man.length);

        if(element.counseling == 'استشارة نفسية')
            relashin.add(element);

        print(relashin.length);

        if(element.counseling == 'استشارة اسرية')
            family.add(element);

        print(family.length);

        if(element.counseling == 'استشارة شعر وجمال')
            hear.add(element);

        print(hear.length);

        if(element.counseling == 'استشارة تغذية')
            health.add(element);

        print(health.length);

        if(element.counseling == 'استشارة برمجية')
            programing.add(element);

        print(programing.length);

      });

      emit(getAllCSuccsessState());
    }).catchError((e){
      print(e.toString());
      emit(getAllCErrorState());
    });
  }

}