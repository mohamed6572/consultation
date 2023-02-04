import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation/models/register_model_C.dart';
import 'package:consultation/models/update_model.dart';
import 'package:consultation/modules/register/cubit/states.dart';
import 'package:consultation/shared/components/components.dart';
import 'package:consultation/shared/components/constens.dart';
import 'package:consultation/shared/network/end_points.dart';
import 'package:consultation/shared/network/remote/dio_helper.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../../models/consultant_model.dart';
import '../../../models/user_model.dart';

class RegesterCubit extends Cubit<RegesterStates> {
  RegesterCubit() : super(RegesterInitialeState());

  static RegesterCubit get(context) => BlocProvider.of(context);

  void UserRegister({
    required String name,
    required String email,
    required String password,
    File? photo,
  }) async {
    ///api
    // emit(RegesterCLodingeState());
    // Dio_Helper.postData(url: RegisterC, data: {
    //   "FCM_TOKEN": await  FirebaseMessaging.instance.getToken(),
    //   "username":name,
    //   "email":email,
    //   "password":password,
    // },).then((value) {
    //   register_model_c = Register_Model_C.fromJson(value.data);
    //   print(register_model_c?.savedUser?.Id);
    //   ID = register_model_c?.savedUser?.Id;
    //   emit(RegesterCUpdateregSucssesState(register_model_c));
    //   ///update
    //   Dio_Helper.putData(url: UPDATEC+ID!, data: {
    //     "photo":'https://firebasestorage.googleapis.com/v0/b/consultant-359115.appspot.com/o/810-8105695_person-icon-grey-person-icon-grey-png.png?alt=media&token=32d90711-f96d-4f93-91d8-fc7c0c41cffa'
    //   },).then((value) {
    //     print("$UPDATEC+'$ID'");
    //     update_model = Update_Model.fromJson(value.data);
    //     emit(RegesterCSucssesState(register_model_c));
    //   }).catchError((e){
    //     print(e.toString());
    //     emit(RegesterCErrorState());
    //   });
    // }).catchError((e){
    //   emit(RegesterCErrorState());
    // });
    ///firebase
    emit(RegesterLodingeState());
    try {
      // Fetch sign-in methods for the email address
      final list =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      // In case list is not empty
      if (list.isNotEmpty) {
        // user using the email address
        ShowToast(text: 'الايميل موجود بالفعل', state: ToastState.ERROR);
      } else {
        FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) {
          createUser(
              uid: value.user!.uid,
              email: email,
              name: name,
              password: password,
              profilePicture: photo);
        }).catchError((e) {
          print('when create user email and password $e');
          emit(RegesterErrorState());
        });
      }
    } catch (e) {
      print('when fetching emails $e');
      emit(RegesterErrorState());
    }
  }

  Register_Model_C? register_model_c;

  ///api
//   Future<void> consultRegister({
//     required String name,
//     required String email,
//     required String password,
//   }) async {
//     emit(RegesterCLodingeState());
//
//     Dio_Helper.postData(url: RegisterC, data: {
//       "FCM_TOKEN": await  FirebaseMessaging.instance.getToken(),
//       "username":name,
//       "email":email,
//       "password":password,
//     },).then((value) {
// register_model_c = Register_Model_C.fromJson(value.data);
// print(register_model_c);
// print(register_model_c?.savedUser?.Id);
// ID = register_model_c?.savedUser?.Id;
//       emit(RegesterCSucssesState(register_model_c));
//     }).catchError((e){
//       emit(RegesterCErrorState());
//     });
//
//
//   }
//
  ///fire base
  void createUser({
    required String? email,
    File? profilePicture,
    required String? name,
    required String? password,
    required String? uid,
  }) async {
    if (profilePicture != null) {
      emit(RegesterLoding_uploadImageState());
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child(
              'profile/${Uri.file(profilePicture.path ?? '').pathSegments.last}')
          .putFile(profilePicture)
          .then((value) {
        value.ref.getDownloadURL().then((value)async {
          Consultant_Model model = Consultant_Model(
              username:  name,
              email: email,
              sId: uid,
              profilePicture: value,
              password: password,
              rating: 0,
              counseling: 'اختار',
              about:  '',
              balance:  '0.0',
              country:  '',
              cVPhoto: 'https://image.shutterstock.com/image-vector/upload-icon-flat-vector-download-260nw-1378175036.jpg',
              phone:  '01000000000',
              EX:  0,
              qualification: '',
              price: '0',
              FCM_TOKEN: await FirebaseMessaging.instance.getToken()
          );

          print(value);
          FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .set(model.toJson())
              .then((value) {
            emit(RegesterSucssesState());
          }).catchError((e) {
            print('when create user $e');
            emit(RegesterErrorState());
          });
        }).catchError((e) {
          print('when uplode image $e');
          emit(RegesterErrorState());
        });
      });
    } else {
      model = Consultant_Model(
          username: name,
          email: email,
          sId: uid,
          password: password,
          rating: 0,
          counseling: 'اختار',
          about:  '',
          balance:  '0.0',
          country:  '',
          cVPhoto: 'https://image.shutterstock.com/image-vector/upload-icon-flat-vector-download-260nw-1378175036.jpg',
          phone:  '01000000000',
          EX:  0,
          qualification: '',
          price: '0',
          FCM_TOKEN: await FirebaseMessaging.instance.getToken(),
          profilePicture:
              'https://firebasestorage.googleapis.com/v0/b/consultant-359115.appspot.com/o/810-8105695_person-icon-grey-person-icon-grey-png.png?alt=media&token=32d90711-f96d-4f93-91d8-fc7c0c41cffa');
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set(model!.toJson())
          .then((value) {
        emit(RegesterSucssesState());
      }).catchError((e) {
        print('when create user $e');
        emit(RegesterErrorState());
      });
    }
  }

  // Update_Model? update_model;
  // void UpdateCRegister({
  //    String? Qualification,
  //    String? duration,
  //    String? counseling,
  //    File? CVPhoto,
  //
  // }){
  //   emit(RegesterCUpdateLodingeState());
  //   firebase_storage.FirebaseStorage.instance
  //       .ref()
  //       .child('CV/${Uri.file(CVPhoto?.path ?? '').pathSegments.last}')
  //       .putFile(CVPhoto!)
  //       .then((value) {
  //     value.ref.getDownloadURL().then((value) {
  //       print(value);
  //       emit(RegesterCUpdateLodingeState());
  //
  //       Dio_Helper.putData(url: UPDATEC+ID!, data: {
  //         "Qualification":Qualification,
  //         "counseling":counseling,
  //         "duration":duration,
  //         "file":value,
  //       },).then((value) {
  //         print("$UPDATEC+'$ID'");
  //         update_model = Update_Model.fromJson(value.data);
  //         print(update_model?.updatedUser?.qualification);
  //         print(update_model?.updatedUser?.counseling);
  //         print(update_model?.updatedUser?.phone);
  //         print(update_model?.updatedUser?.duration);
  //         print(update_model?.updatedUser?.profilePicture);
  //         emit(RegesterCUpdateSucssesState());
  //       }).catchError((e){
  //         print(e.toString());
  //         emit(RegesterCUpdateErrorState());
  //       });
  //
  //     }).catchError((error) {
  //       emit(RegesterCUpdateErrorState());
  //     });
  //   }).catchError((error) {
  //     emit(RegesterCUpdateErrorState());
  //   });
  //
  //
  //
  //
  // }
  //
  // void UpdateCRegister1({
  //   File? profilePicture,
  //   String? About,
  //   String? country,
  //   String? phone,
  //   String? price,
  // }) {
  //   firebase_storage.FirebaseStorage.instance
  //       .ref()
  //       .child(
  //           'profile/${Uri.file(profilePicture?.path ?? '').pathSegments.last}')
  //       .putFile(profilePicture!)
  //       .then((value) {
  //     value.ref.getDownloadURL().then((value) {
  //       print(value);
  //       emit(RegesterCUpdateLodingeState());
  //       Dio_Helper.putData(
  //         url: UPDATEC + ID!,
  //         data: {
  //           "photo": value,
  //           "About": About,
  //           "price": price,
  //           "rating": 0,
  //           "country": country,
  //           "phone": phone,
  //         },
  //       ).then((value) {
  //         print("$UPDATEC+'$ID'");
  //         update_model = Update_Model.fromJson(value.data);
  //         print(update_model?.updatedUser?.qualification);
  //         print(update_model?.updatedUser?.username);
  //         print(update_model?.updatedUser?.Id);
  //         print(update_model?.updatedUser?.email);
  //         print(update_model?.updatedUser?.password);
  //         print(update_model?.updatedUser?.about);
  //         print(update_model?.updatedUser?.counseling);
  //         print(update_model?.updatedUser?.phone);
  //         print(update_model?.updatedUser?.duration);
  //         print(update_model?.updatedUser?.profilePicture);
  //         emit(RegesterCUpdateSucssesState());
  //       }).catchError((e) {
  //         print(e.toString());
  //         emit(RegesterCUpdateErrorState());
  //       });
  //     }).catchError((error) {
  //       emit(RegesterCUpdateErrorState());
  //     });
  //   }).catchError((error) {
  //     emit(RegesterCUpdateErrorState());
  //   });
  // }

  // void uploadimage({
  //   required String? imagename,
  // }) {
  //   emit(RegesteruploadImageLodingeState());
  //
  //   Dio_Helper.postData(
  //     url: RegisterC,
  //     data: {
  //       "name": imagename,
  //     },
  //   ).then((value) {
  //     print(value.data);
  //     emit(RegesterruploadImageSucssesState());
  //   }).catchError((e) {
  //     emit(RegesterruploadImageErrorState());
  //   });
  // }

  IconData suffix = Icons.visibility;
  bool isPasword = true;
  bool isUser = true;

  void changePasswordVisability() {
    isPasword = !isPasword;
    suffix = isPasword ? Icons.visibility : Icons.visibility_off;
    emit(RegesterChangePasswordState());
  }

  void changeUserRegister() {
    isUser = !isUser;
    emit(RegesterChangeregisterState());
  }

  List<Map> items = [
    {
      'image': 'assets/images/consultation_icon/cat1.png',
      'name': 'استشارة قانونية'
    },
    {
      'image': 'assets/images/consultation_icon/cat2.png',
      'name': 'استشارة معمارية'
    },
    {
      'image': 'assets/images/consultation_icon/cat3.png',
      'name': 'استشارة رجل اعمال'
    },
    {
      'image': 'assets/images/consultation_icon/cat4.png',
      'name': 'استشارة نفسية'
    },
    {
      'image': 'assets/images/consultation_icon/cat5.png',
      'name': 'استشارة اسرية'
    },
    {
      'image': 'assets/images/consultation_icon/cat7.png',
      'name': 'استشارة شعر وجمال'
    },
    {
      'image': 'assets/images/consultation_icon/cat8.png',
      'name': 'استشارة تغذية'
    },
    {
      'image': 'assets/images/consultation_icon/cat9.png',
      'name': 'استشارة برميجة'
    },
  ];
  String? selectedValue;

  void changeSelected(value) {
    selectedValue = value;
    emit(RegesterChangeSelectedState());
  }

  File? profileimage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileimage = File(pickedFile.path);

      print('==.>$profileimage');
      print('==.>${profileimage?.path}');
      emit(RegesterImagePickedSuccsessState());
    } else {
      print('no image selected');
      emit(RegesterImagePickedErrorState());
    }
  }

  File? CVimage;
  var pickerCV = ImagePicker();

  Future<void> getCVImage() async {
    final pickedCVFile = await pickerCV.pickImage(source: ImageSource.gallery);
    if (pickedCVFile != null) {
      CVimage = File(pickedCVFile.path);

      print('==.>$CVimage');
      print('==.>${CVimage?.path}');
      emit(RegesterCVImagePickedSuccsessState());
    } else {
      print('no image selected');
      emit(RegesterCVImagePickedErrorState());
    }
  }
}
