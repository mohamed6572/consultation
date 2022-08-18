import 'dart:convert';
import 'dart:ffi';
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
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:image_picker/image_picker.dart';

import '../../models/LoginC_Model.dart';
import '../../models/Message_Model.dart';
import '../../models/catI_tem_model.dart';
import '../../models/chat/all_conversation.dart';
import '../../models/chat/conversation.dart';
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
    String? About,
    String? country,
    String? phone,
    String? price,
  }){
    emit(UpdateLodingState());

    Dio_Helper.putData(url: UPDATEC+ID!, data: {
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
  //rating after chat
  void rateConsaltant({
    int? rate,
    String? id,
  }){
    emit(RatingLodingState());
    Dio_Helper.putData(url: UPDATEC+id!, data: {
      "rating":rate,
    },).then((value) {
      print("$UPDATEC+'$ID'");
      update_Consultant_model = Update_Model.fromJson(value.data);
      emit(RatingSuccsessState());
    }).catchError((e){
      print(e.toString());
      emit(RatingErrorState());
    });


  }
//change password
  void ChangePasswrodConsaltant({
    String? password,
  }){
    emit(UpdateLodingState());
    Dio_Helper.putData(url: UPDATEC+ID!, data: {
      "password":password,
    },).then((value) {
      print("$UPDATEC+'$ID'");
      update_Consultant_model = Update_Model.fromJson(value.data);
      emit(UpdateSuccsessState());
    }).catchError((e){
      print(e.toString());
      emit(UpdateErrorState());
    });


  }
  //user
  void ChangePasswrodUser({
    String? password,
  }){
    emit(UpdateULodingState());
    Dio_Helper.putData(url: UPDATEU+ID!,token: tokenU, data: {
      "password":password,
    },).then((value) {
      print("$UPDATEU+'$ID'");
      emit(UpdateUSuccsessState());
    }).catchError((e){
      print(e.toString());
      emit(UpdateUErrorState());
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
  List<Consultants> consultant =[];
  List<Consultants> consultant1 =[];
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
    Dio_Helper.getData(url: GetAllC,token: token??tokenU).then((value) {
      consultant_model_for_loist = all_consultant_model.fromJson(value.data);
      consultant_model_for_loist?.consultants?.forEach((element) {
consultant.add(element);
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

        if(element.counseling == 'استشارة برميجة')
            programing.add(element);

        print(programing.length);

      });

      emit(getAllCSuccsessState());
    }).catchError((e){
      print(e.toString());
      emit(getAllCErrorState());
    });
  }


  void UpdateConsultantImage(
  {
    File? profilePicture,
    String? About,
    String? country,
    String? phone,
    String? price,
}
      ) {

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('CV/${Uri.file(profilePicture?.path ?? '').pathSegments.last}')
        .putFile(profilePicture!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        emit(UpdateLodingState());

        Dio_Helper.putData(url: UPDATEC+ID!, data: {
          "About":About,
          "price":price,
          "country":country,
          "phone":phone,
          "photo":value,
        },).then((value) {
          print("$UPDATEC+'$ID'");
          update_Consultant_model = Update_Model.fromJson(value.data);
          emit(UpdateSuccsessState());
        }).catchError((e){
          print(e.toString());
          emit(UpdateErrorState());
        });
      }).catchError((error) {
        emit(UpdateErrorState());
      });
    }).catchError((error) {
      emit(UpdateErrorState());
    });
  }

  //message & chat
  List<MessageModel> messages = [];


  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    // MessageModel model = MessageModel(
    //     dateTime: dateTime,
    //     text: text,
    //     receiverId: receiverId,
    //     senderId: userModel?.uId);
// set my chats

    // FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(userModel?.uId)
    //     .collection('chats')
    //     .doc(receiverId)
    //     .collection('messages')
    //     .add(model.toJson())
    //     .then((value) {
    //   emit(SendMessageSucsesState());
    // }).catchError((error) {
    //   emit(SendMessageErrorState());
    // });
// set reseiver chats
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(receiverId)
//         .collection('chats')
//         .doc(userModel?.uId)
//         .collection('messages')
//         .add(model.toJson())
//         .then((value) {
//       emit(SendMessageSucsesState());
//     }).catchError((error) {
//       emit(SendMessageErrorState());
//     });
  }

  /// create conversation
  /// get all conversation in chat screan
  /// messages get messages by get conversation by  two users


///first thing make the conversation
///second get it into the chat
///therd into to chat add two id to method messages
///or get two conversation to add the ides to messages
//receiverId
//senderId
  Conversation? conversation ;
void createConversation({
  required String receiverId,
  required String senderId,
}){
  Dio_Helper.postData(url: createCon , data:{
    "senderId":senderId,
    "receiverId":receiverId,
  } ).then((value) {
    print(receiverId);
    print(senderId);
    conversation = Conversation.fromJson(value.data);
    emit(createConversationSucsesState());
  }).catchError((e){
    print(e.toString());
    emit(createConversationErrorState());
  });
}

/////
  All_Conversation? all_conversation1 ;
  List<dynamic> all_Conversations = [];
void GetAllConversation(){
  Dio_Helper.getData(url: getAllConversation+ID!  ).then((value) {
    // all_Conversations = All_Conversation.fromJson(value.data)as List;
    // print(all_Conversations);
    all_Conversations = value.data;
    emit(getAllConversationSucsesState());
  }).catchError((e){
    print(e.toString());
    emit(getAllConversationErrorState());
  });
}
// void GetConversation(){
//   Dio_Helper.getData(url: getAllConversation+ID!+  ).then((value) {
//     //Map<dynamic, dynamic> data = new Map<dynamic, dynamic>.from(json.decode(value.data));
//     all_Conversations = value.data;
//     print(all_Conversations[0]['members'][0]);
//    // print(data);
//     // all_conversation = All_Conversation.fromJson(value.data);
//     // print(all_conversation?.members![0]);
//     // print(all_conversation?.members![1]);
//     emit(getAllConversationSucsesState());
//   }).catchError((e){
//     print(e.toString());
//     emit(getAllConversationErrorState());
//   });
// }

}