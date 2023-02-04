import 'dart:io';

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation/layout/cubit/states.dart';
import 'package:consultation/models/all_cosultant_model.dart';
import 'package:consultation/models/consultant_model.dart';
import 'package:consultation/models/update_model.dart';
import 'package:consultation/models/user_model.dart';
import 'package:consultation/modules/balance/balance.dart';
import 'package:consultation/modules/chat/chat.dart';
import 'package:consultation/modules/home/home.dart';
import 'package:consultation/modules/login/cubit/cubit.dart';
import 'package:consultation/modules/profile/profile.dart';
import 'package:consultation/shared/components/constens.dart';
import 'package:consultation/shared/network/end_points.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:image_picker/image_picker.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:uuid/uuid.dart';

import '../../models/Message_Model.dart';
import '../../models/chat/all_conversation.dart';
import '../../models/chat/conversation.dart';
import '../../models/visa_payment.dart';
import '../../modules/login/login_screan.dart';
import '../../modules/login/login_screan1.dart';
import '../../shared/components/components.dart';
import '../../shared/network/remote/dio_helper.dart';
import 'package:consultation/shared/network/local/cash_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  List<Widget> screans = [
    Home_Screan(),
    Chat_Screan(),
    Profile_Screan(),
    Balance_Screan()
  ];

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =ItemPositionsListener.create();

  void SignOut(context) async {
    // cash_helper.removeData(key: 'token').then((value) {
    // cash_helper.removeData(key: 'ID');
    // ID = cash_helper.getData(key: 'ID');
    // token = cash_helper.getData(key: 'token');
    // print('remove $ID');
    // print(token);
    await FirebaseAuth.instance.signOut();
    UserID = '';

    emit(signoutSucssesState());

    // });
  }

  List<Widget> titles = [
    Column(
      children: [
        SizedBox(
          height: 10,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image(
            image: AssetImage('assets/images/logo1.png'),
            height: 70,
            fit: BoxFit.contain,
          ),
        )
      ],
    ),
    Text(
      'الدردشات',
      style: TextStyle(fontWeight: FontWeight.w500),
    ),
    Text(
      'الملف الشخصي',
      style: TextStyle(fontWeight: FontWeight.w500),
    ),
    Text(
      'رصيد الحساب',
      style: TextStyle(fontWeight: FontWeight.w500),
    )
  ];
  List<BottomBarItem> botItems = [
    BottomBarItem(
      inActiveItem: Icon(
        Icons.home_outlined,
        color: Colors.blueGrey.shade500,
      ),
      activeItem: Icon(
        Icons.home,
        color: Colors.white,
      ),
      itemLabel: 'الرئيسية',
    ),
    BottomBarItem(
      inActiveItem: Icon(
        Icons.message_outlined,
        color: Colors.blueGrey.shade500,
      ),
      activeItem: Icon(
        Icons.message,
        color: Colors.white,
      ),
      itemLabel: 'الدردشة',
    ),
    BottomBarItem(
      inActiveItem: Icon(
        Icons.person_outline_outlined,
        color: Colors.blueGrey.shade500,
      ),
      activeItem: Icon(
        Icons.person,
        color: Colors.white,
      ),
      itemLabel: 'الملف الشخصي',
    ),
    BottomBarItem(
      inActiveItem: Icon(
        Icons.attach_money_outlined,
        color: Colors.blueGrey.shade500,
      ),
      activeItem: Icon(
        Icons.attach_money,
        color: Colors.white,
      ),
      itemLabel: 'الرصيد',
    ),
  ];

  List<BottomNavigationBarItem> botItemsU = [
    BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'الرئيسية'),
    BottomNavigationBarItem(icon: Icon(Icons.message), label: 'الدردشة'),
  ];

  int currentIndex = 0;

  void ChangeBotomIndex(index) {
    currentIndex = index;
    emit(AppchangeBotBarState());
  }

  void ChaIndex() {
    FirebaseFirestore.instance
        .collection('chats')
        .doc('2effc40f-6a47-419b-b848-966fa1ece9e3').collection('messege').doc('U0q4K06dgt77lsATSRVR').delete();
    emit(AppchangeBotBarState());
  }

  ///rating
  double rating = 0;

  void RatingApp(rat) {
    rating = rat;
    emit(AppRatingState());
  }

  ///send email payment
  Future sendEmailPayment({
    required String email,
    required String paypal,
    required String price,
  }) async {
    const serviceId = 'service_oibints'; //serviceId from emailjs
    const templateId = 'template_hdcwu0s'; //your templateId from emailjs
    const userId = 'HFyf4BbHpnW_kpDC-'; //your Public Key from emailjs
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send-form');
    final response = await http.post(
      url,
      body: {
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'accessToken': '15yju4YQPzN1tEIeWiglA', //your Private Key from emailjs
        'user_email': email,
        'user_payment_email': paypal,
        'user_price': price
      },
      headers: {
        'origin': 'http://localhost',
        'contentType': 'application/json',
      },
    );
    print(response.body);
  }

  ///send email complaint
  Future sendEmailComplaint({
    required String email,
    required String opnion,
    required String complaint,
  }) async {
    const serviceId = 'service_oibints'; //serviceId from emailjs
    const templateId = 'template_6dpv03p'; //your templateId from emailjs
    const userId = 'HFyf4BbHpnW_kpDC-'; //your Public Key from emailjs
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send-form');
    final response = await http.post(
      url,
      body: {
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'accessToken': '15yju4YQPzN1tEIeWiglA', //your Private Key from emailjs
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

  void uploadProfileImage({
    required String name,
    required String phone,
    required String About,
    required String country,
    required String price,
    required String qualification,
    required String counseling,
    required int EX,
  }) {
    emit(UpdateLodingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
            'profile/${Uri.file(editprofileimage?.path ?? '').pathSegments.last}')
        .putFile(editprofileimage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        UpdateConsaltant(
          name: name,
          phone: phone,
          image: value,
          price: price,
          About: About,
          country: country,
          qualification: qualification,
          counseling: counseling,
          EX: EX,
        );
        editprofileimage = null;
      }).catchError((e) {
        print('when get link');
        print(e.toString());
        emit(UpdateErrorState());
      });
    }).catchError((e) {
      print('when update image');
      print(e.toString());
      emit(UpdateErrorState());
    });
  }

  ///
  void uploadCVImage({
    required String name,
    required String phone,
    required String About,
    required String country,
    required String price,
    required String qualification,
    required String counseling,
    required int EX,
  }) {
    emit(Update_CV_LodingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('CV/${Uri.file(CVimage?.path ?? '').pathSegments.last}')
        .putFile(CVimage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        UpdateConsaltant(
          name: name,
          phone: phone,
          CvPhoto: value,
          price: price,
          About: About,
          country: country,
          qualification: qualification,
          counseling: counseling,
          EX: EX,
        );
        CVimage = null;
      }).catchError((e) {
        print('when get link');
        print(e.toString());
        emit(UpdateErrorState());
      });
    }).catchError((e) {
      print('when update image');
      print(e.toString());
      emit(UpdateErrorState());
    });
  }

  ///
  void UpdateConsaltant({
    required String name,
    required String phone,
    String? CvPhoto,
    String? image,
    required String About,
    required String country,
    required String price,
    required String qualification,
    required String counseling,
    required int EX,
  }) async {
    Consultant_Model model1 = Consultant_Model(
      username: name,
      phone: phone,
      email: usermodel?.email,
      sId: usermodel?.sId,
      cVPhoto: CvPhoto ?? usermodel?.cVPhoto,
      profilePicture: image ?? usermodel?.profilePicture,
      price: price,
      about: About,
      country: country,
      FCM_TOKEN: await FirebaseMessaging.instance.getToken(),
      qualification: qualification,
      counseling: counseling,
      EX: EX,
      password: usermodel?.password,
      rating: usermodel?.rating,
      balance: usermodel?.balance,
    );

    await FirebaseFirestore.instance
        .collection('users')
        .doc(usermodel?.sId)
        .update(model1.toJson())
        .then((value) {
      ShowToast(text: 'تم التعديل بنجاح', state: ToastState.SUCSSES);
      emit(UpdateSuccsessState());
      GetConsaltant();
    }).catchError((e) {
      print('when update');
      print(e.toString());
      emit(UpdateErrorState());
    });
  }

  //
  //
  // void UpdateWithPrpfilePhoto({
  //   String? About,
  //   String? country,
  //   String? phone,
  //   String? price,
  //   String? username,
  //   String? FCM_TOKEN,
  //   String? qualification,
  //   String? counseling,
  //   String? email,
  //   String? cVPhoto,
  //   String? password,
  //   File? profilePicture,
  //   String? balance,
  //   String? sId,
  //   int? EX,
  //   int? rating,
  // })async{
  //   emit(UpdateLodingState());
  //   firebase_storage.FirebaseStorage.instance
  //       .ref()
  //       .child('profile/${Uri.file(profilePicture?.path ?? '').pathSegments.last}')
  //       .putFile(profilePicture!)
  //       .then((value) {
  //     value.ref.getDownloadURL().then((value)async {
  //       print(value);
  //       print(UserID);
  //       print(FirebaseAuth.instance.currentUser?.uid);
  //       usermodel = Consultant_Model(
  //         price: price,
  //         about: About,
  //         country: country,
  //         phone: phone,
  //         username: username,
  //         FCM_TOKEN: FCM_TOKEN,
  //         qualification: qualification,
  //         counseling: counseling,
  //         EX: EX,
  //         email: email,
  //         cVPhoto:cVPhoto ,
  //         password:password ,
  //         profilePicture:value ,
  //         rating: rating,
  //         balance:balance ,
  //         sId : sId,
  //       );
  //
  //       await FirebaseFirestore.instance
  //           .collection('users')
  //           .doc(FirebaseAuth.instance.currentUser?.uid)
  //           .update(usermodel!.toJson())
  //           .then((value) {
  //         print('update succses');
  //         emit(UpdateSuccsessState());
  //       }).catchError((e) {
  //         print('when update');
  //         print(e.toString());
  //         emit(UpdateErrorState());
  //       });
  //     }).catchError((e) {
  //       print('when get link');
  //       print(e.toString());
  //       emit(UpdateErrorState());
  //     });
  //   }).catchError((e) {
  //     print('when update image');
  //     print(e.toString());
  //     emit(UpdateErrorState());
  //   });
  // }
  // void UpdateWithCVPhoto({
  //   String? About,
  //   String? country,
  //   String? phone,
  //   String? price,
  //   String? username,
  //   String? FCM_TOKEN,
  //   String? qualification,
  //   String? counseling,
  //   String? email,
  //   File? cVPhoto,
  //   String? password,
  //   String? profilePicture,
  //   String? balance,
  //   String? sId,
  //   int? EX,
  //   int? rating,
  // })async{
  //   emit(UpdateLodingState());
  //   firebase_storage.FirebaseStorage.instance
  //       .ref()
  //       .child('CV/${Uri.file(cVPhoto?.path ?? '').pathSegments.last}')
  //       .putFile(cVPhoto!)
  //       .then((value) {
  //     value.ref.getDownloadURL().then((value)async {
  //       print(value);
  //       print(UserID);
  //       print(FirebaseAuth.instance.currentUser?.uid);
  //       usermodel = Consultant_Model(
  //         price: price,
  //         about: About,
  //         country: country,
  //         phone: phone,
  //         username: username,
  //         FCM_TOKEN: FCM_TOKEN,
  //         qualification: qualification,
  //         counseling: counseling,
  //         EX: EX,
  //         email: email,
  //         cVPhoto:value ,
  //         password:password ,
  //         profilePicture:profilePicture ,
  //         rating: rating,
  //         balance:balance ,
  //         sId : sId,
  //       );
  //
  //       await FirebaseFirestore.instance
  //           .collection('users')
  //           .doc(FirebaseAuth.instance.currentUser?.uid)
  //           .update(usermodel!.toJson())
  //           .then((value) {
  //         print('update succses');
  //         emit(UpdateSuccsessState());
  //       }).catchError((e) {
  //         print('when update');
  //         print(e.toString());
  //         emit(UpdateErrorState());
  //       });
  //     }).catchError((e) {
  //       print('when get link');
  //       print(e.toString());
  //       emit(UpdateErrorState());
  //     });
  //   }).catchError((e) {
  //     print('when update image');
  //     print(e.toString());
  //     emit(UpdateErrorState());
  //   });
  // }
  // void UpdateWithCVPhoto_profile({
  //   String? About,
  //   String? country,
  //   String? phone,
  //   String? price,
  //   String? username,
  //   String? FCM_TOKEN,
  //   String? qualification,
  //   String? counseling,
  //   String? email,
  //   File? cVPhoto,
  //   String? password,
  //   File? profilePicture,
  //   String? balance,
  //   String? sId,
  //   int? EX,
  //   int? rating,
  // })async{
  //   //String cv;
  //   emit(UpdateLodingState());
  //  await firebase_storage.FirebaseStorage.instance
  //       .ref()
  //       .child('CV/${Uri.file(cVPhoto?.path ?? '').pathSegments.last}')
  //       .putFile(cVPhoto!)
  //       .then((value) {
  //     value.ref.getDownloadURL().then((value1)async {
  //
  //      await firebase_storage.FirebaseStorage.instance
  //           .ref()
  //           .child('CV/${Uri.file(profilePicture?.path ?? '').pathSegments.last}')
  //           .putFile(profilePicture!)
  //           .then((value) {
  //         value.ref.getDownloadURL().then((value)async {
  //
  //           print(value);
  //           print(UserID);
  //           print(FirebaseAuth.instance.currentUser?.uid);
  //           usermodel = Consultant_Model(
  //             price: price,
  //             about: About,
  //             country: country,
  //             phone: phone,
  //             username: username,
  //             FCM_TOKEN: FCM_TOKEN,
  //             qualification: qualification,
  //             counseling: counseling,
  //             EX: EX,
  //             email: email,
  //             cVPhoto:value1 ,
  //             password:password ,
  //             profilePicture:value,
  //             rating: rating,
  //             balance:balance ,
  //             sId : sId,
  //           );
  //
  //           await FirebaseFirestore.instance
  //               .collection('users')
  //               .doc(FirebaseAuth.instance.currentUser?.uid)
  //               .update(usermodel!.toJson())
  //               .then((value) {
  //             print('update succses');
  //             emit(UpdateSuccsessState());
  //           }).catchError((e) {
  //             print('when update');
  //             print(e.toString());
  //             emit(UpdateErrorState());
  //           });
  //         }).catchError((e) {
  //           print('when get link');
  //           print(e.toString());
  //           emit(UpdateErrorState());
  //         });
  //       }).catchError((e) {
  //         print('when update image');
  //         print(e.toString());
  //         emit(UpdateErrorState());
  //       });
  //     }).catchError((e) {
  //       print('when get link');
  //       print(e.toString());
  //       emit(UpdateErrorState());
  //     });
  //   }).catchError((e) {
  //     print('when update image');
  //     print(e.toString());
  //     emit(UpdateErrorState());
  //   });
  // }

  //edit profile
  // void UpdateConsaltant({
  //   String? About,
  //   String? country,
  //   String? phone,
  //   String? price,
  //   String? username,
  //   String? FCM_TOKEN,
  //   String? qualification,
  //   String? counseling,
  //   String? email,
  //   String? cVPhoto,
  //   String? password,
  //   String? profilePicture,
  //   String? balance,
  //   String? sId,
  //   int? EX,
  //   int? rating,
  // }) async {
  //     usermodel = Consultant_Model(
  //       price: price,
  //       about: About,
  //       country: country,
  //       phone: phone,
  //       username: username,
  //       FCM_TOKEN: FCM_TOKEN,
  //       qualification: qualification,
  //       counseling: counseling,
  //       EX: EX,
  //       email: email,
  //       cVPhoto:cVPhoto ,
  //       password:password ,
  //       profilePicture:profilePicture ,
  //       rating: rating,
  //       balance:balance ,
  //       sId : sId,
  //     );
  //
  //   emit(UpdateLodingState());
  //   await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(FirebaseAuth.instance.currentUser?.uid)
  //       .update(usermodel!.toJson())
  //       .then((value) {
  //     print('update succses');
  //     emit(UpdateSuccsessState());
  //   }).catchError((e) {
  //     print(e.toString());
  //     emit(UpdateErrorState());
  //   });
  //
  // }

  //rating after chat
  // void rateConsaltant({
  //   int? rate,
  //   String? id,
  // }){
  //   emit(RatingLodingState());
  //   Dio_Helper.putData(url: UPDATEC+id!, data: {
  //     "rating":rate,
  //   },).then((value) {
  //     print("$UPDATEC+'$ID'");
  //     update_Consultant_model = Update_Model.fromJson(value.data);
  //     emit(RatingSuccsessState());
  //   }).catchError((e){
  //     print(e.toString());
  //     emit(RatingErrorState());
  //   });
  //
  //
  // }
//change password
  void ChangePasswrodConsaltant({
    String? password,
  }) {
    emit(UpdateLodingState());

    // Dio_Helper.putData(url: UPDATEC+ID!, data: {
    //   "password":password,
    // },)
    FirebaseAuth.instance.currentUser?.updatePassword(password!).then((value) {
      emit(UpdateSuccsessState());
      ShowToast(text: 'تم التغيير بنجاح', state: ToastState.SUCSSES);
    }).catchError((e) {
      print(e.toString());
      ShowToast(
          text: 'لا يمكنك اجراء العمليه لانك مسجل عن طريق جوجل',
          state: ToastState.ERROR);
      emit(UpdateErrorState());
    });
  }

  //user
  void ChangePasswrodUser({
    String? password,
  }) {
    emit(UpdateULodingState());
    Dio_Helper.putData(
      url: UPDATEU + ID!,
      token: tokenU,
      data: {
        "password": password,
      },
    ).then((value) {
      print("$UPDATEU+'$ID'");
      emit(UpdateUSuccsessState());
    }).catchError((e) {
      print(e.toString());
      emit(UpdateUErrorState());
    });
  }

  void Update_Balance({
    String? balance,
    String? id,
  }) {
    emit(UpdateULodingState());
    Dio_Helper.putData(
      url: UPDATEC + id!,
      data: {
        "balance": balance,
      },
    ).then((value) {
      emit(UpdateSuccsessState());

      print('heeloo');
    }).catchError((e) {
      print(e.toString());
      emit(UpdateErrorState());
    });
  }

  // void Update_Client({
  //   int? clint,
  //   String? id,
  // }) {
  //   emit(UpdateULodingState());
  //   Dio_Helper.putData(
  //     url: UPDATEC + id!,
  //     data: {
  //       "clinet": clint,
  //     },
  //   ).then((value) {
  //     emit(UpdateSuccsessState());
  //
  //     print('heeloo');
  //   }).catchError((e) {
  //     print(e.toString());
  //     emit(UpdateErrorState());
  //   });
  // }
  // void Update_Conseling({
  //   int? counseling,
  //   String? id,
  // }) {
  //   emit(UpdateULodingState());
  //   Dio_Helper.putData(
  //     url: UPDATEC + id!,
  //     data: {
  //       "clinet": counseling,
  //     },
  //   ).then((value) {
  //     emit(UpdateSuccsessState());
  //
  //     print('heeloo');
  //   }).catchError((e) {
  //     print(e.toString());
  //     emit(UpdateErrorState());
  //   });
  // }

  Consultant_Model? usermodel;

//get consltant data
  void GetConsaltant() async{
    //Dio_Helper.getData(url: 'users/find1/$ID',token: token)
    emit(getCLodingState());
   await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      usermodel = Consultant_Model.fromJson(value.data()!);
      print(usermodel?.username);
      print(usermodel?.email);
      print(usermodel?.sId);
      print(usermodel?.password);
      print(usermodel?.qualification);
      print(usermodel?.price);
      print(usermodel?.country);
      print(usermodel?.profilePicture);
      print(usermodel?.cVPhoto);
      print(usermodel?.counseling);

      emit(getCSuccsessState());
    }).catchError((e) {
      print(e.toString());
      emit(getCErrorState());
    });
  }

  //get all consultant

  List<Consultant_Model> consultant = [];
  List<Consultant_Model> consultant1 = [];
  List<Consultant_Model> law = [];
  List<Consultant_Model> engeier = [];
  List<Consultant_Model> man = [];
  List<Consultant_Model> relashin = [];
  List<Consultant_Model> family = [];
  List<Consultant_Model> hear = [];
  List<Consultant_Model> health = [];
  List<Consultant_Model> programing = [];

  void GetAllConsaltant() {
    law = [];
    engeier = [];
    man = [];
    relashin = [];
    family = [];
    hear = [];
    health = [];
    programing = [];

    emit(getAllCLodingState());
    //Dio_Helper.getData(url: GetAllC, token: token)
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        // print('all ${element.data()['email']}');
        // Consultant_Model model = Consultant_Model.fromJson(element.data());
        // print(model.email![2]);
        // print(model.email!);
        if (element.data()['counseling'] == 'استشارة قانونية')
          law.add(Consultant_Model.fromJson(element.data()));

        print(law.length);
        if (element.data()['counseling'] == 'استشارة معمارية')
          engeier.add(Consultant_Model.fromJson(element.data()));

        print(engeier.length);

        if (element.data()['counseling'] == 'استشارة رجل اعمال')
          man.add(Consultant_Model.fromJson(element.data()));

        print(man.length);

        if (element.data()['counseling'] == 'استشارة نفسية')
          relashin.add(Consultant_Model.fromJson(element.data()));

        print(relashin.length);

        if (element.data()['counseling'] == 'استشارة اسرية')
          family.add(Consultant_Model.fromJson(element.data()));

        print(family.length);

        if (element.data()['counseling'] == 'استشارة شعر وجمال')
          hear.add(Consultant_Model.fromJson(element.data()));

        print(hear.length);

        if (element.data()['counseling'] == 'استشارة تغذية')
          health.add(Consultant_Model.fromJson(element.data()));

        print(health.length);

        if (element.data()['counseling'] == 'استشارة برميجة')
          programing.add(Consultant_Model.fromJson(element.data()));
        print(programing.length);
      });

      //Consultant_Model model = Consultant_Model.fromJson(value.metadata);
      //print('all $value');
      // consultant_model_for_loist = all_consultant_model.fromJson(value.data);
      // consultant_model_for_loist?.consultants?.forEach((element) {
      //   consultant.add(element);

      emit(getAllCSuccsessState());
    }).catchError((e) {
      print(e.toString());
      emit(getAllCErrorState());
    });
  }

  String? selectedValue;

  void changeSelected(value) {
    selectedValue = value;
    emit(ChangeSelected_Consuling_State());
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

  File? CVimage;
  var pickerCV = ImagePicker();

  Future<void> getCVImage() async {
    final pickedCVFile = await pickerCV.pickImage(source: ImageSource.gallery);
    if (pickedCVFile != null) {
      CVimage = File(pickedCVFile.path);

      print('==.>$CVimage');
      print('==.>${CVimage?.path}');
      emit(CVImagePickedSuccsessState());
    } else {
      print('no image selected');
      emit(CVImagePickedErrorState());
    }
  }

  // void UpdateConsultantImage({
  //   File? profilePicture,
  //   String? About,
  //   String? country,
  //   String? phone,
  //   String? price,
  // }) {
  //   firebase_storage.FirebaseStorage.instance
  //       .ref()
  //       .child('CV/${Uri.file(profilePicture?.path ?? '').pathSegments.last}')
  //       .putFile(profilePicture!)
  //       .then((value) {
  //     value.ref.getDownloadURL().then((value) {
  //       print(value);
  //       emit(UpdateLodingState());
  //
  //       Dio_Helper.putData(
  //         url: UPDATEC + ID!,
  //         data: {
  //           "About": About,
  //           "price": price,
  //           "country": country,
  //           "phone": phone,
  //           "photo": value,
  //         },
  //       ).then((value) {
  //         print("$UPDATEC+'$ID'");
  //         //update_Consultant_model = Update_Model.fromJson(value.data);
  //         emit(UpdateSuccsessState());
  //       }).catchError((e) {
  //         print(e.toString());
  //         emit(UpdateErrorState());
  //       });
  //     }).catchError((error) {
  //       emit(UpdateErrorState());
  //     });
  //   }).catchError((error) {
  //     emit(UpdateErrorState());
  //   });
  // }

  // message & chat
  void sendMessage({
    // required String receiverId,
    // required String dateTime,
    required List<String> text,
  required String id,
    // String? Image,
  }) {
    Message_Model model = Message_Model(
        // dateTime: dateTime,
        messege: text,
        // receiverId: receiverId,
        // image: Image,
        // senderId: id
        );
// set my chats

    FirebaseFirestore.instance
        .collection('chats')
        .doc(id)
        .collection('messages').doc(id)
        .set(model.toJson())
        .then((value) {
      emit(SendMessageSucsesState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
// set reseiver chats
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(receiverId)
//         .collection('chats')
//         .doc(id)
//         .collection('messages')
//         .add(model.toJson())
//         .then((value) {
//       emit(SendMessageSucsesState());
//     }).catchError((error) {
//       emit(SendMessageErrorState());
//     });
  }

  List<String> messages = [];

  Future getMessages({
    required String id,
  })async {
    // Dio_Helper.getData(url: getmessage+ID!,).then((value) {
    // value.data.forEach((e){
    //   messages.add(Message_Model.fromJson(e));
    // });
    //   emit(getMessageSucsesState());
    // }).catchError((e){
    //   print(e.toString());
    //   emit(getMessageErrorState());
    // });
   return FirebaseFirestore.instance
        .collection('chats')
        .doc(id)
        .collection('messages')
        .doc(id)
        .snapshots()
        .listen((event) {
      messages = [];
      print('me ${event.data()!['messege']}');
// messages.add(event.data()!['messege'].toString());
//       print('meee ${messages}');
//       print('meee ${messages.length}');
      event.data()?['messege'].forEach((e) async {
        messages.add(e);
        print('meee ${messages}');
        print('meee ${messages.length}');
      });
      emit(getMessageSucsesState());
    });

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

  void createConversation({
    required Reciver reciver,
    required Sender sender,
  })async {
    // Dio_Helper.postData(url: createCon, data: {
    //   "senderId": usermodel?.sId,
    //   "receiverId": receiverId,
    // })
    String id = Uuid().v4();
    Conversation? conversation =
        Conversation(
            Id: id,
            createdAt: '0',
            reciver: reciver,
            sender: sender,
          //messege: []
        );
  await  FirebaseFirestore.instance
        .collection('chats')
        .doc(id)
       .set(conversation.toJson())
        .then((value) {
      print(usermodel?.sId);
      print(sender.Image);
      print(reciver.Image);
      emit(createConversationSucsesState());
    }).catchError((e) {
      print(e.toString());
      emit(createConversationErrorState());
    });
  }

//visa payment

  visa_Model? visa_model;

  void visa_Payment({
    required String number,
    required String name,
    required String cvv,
    required int expiry_month,
    required int amount,
    required int expiry_year,
  }) {
    Dio_Helper.postData(url: payment_visa, data: {
      "number": number,
      "expiry_month": expiry_month,
      "amount": amount,
      "expiry_year": expiry_year,
      "name": name,
      "cvv": cvv
    }).then((value) {
      emit(paymentLoadingState());
      print(name);
      print(number.replaceAll(RegExp(r"\s+"), ""));
      // print(cvv);
      // print(amount);
      // print(expiry_month);
      // print(expiry_year);
      visa_model = visa_Model.fromJson(value.data);
      print(visa_model?.message?.length);
      emit(paymentSucssesState(model: visa_model));
    }).catchError((e) {
      print(e.toString());
      emit(paymentErrorState());
    });
  }

/////
  Conversation? conversation;

  List<Conversation>? all_Conversations = [];
  List<Conversation>? Conversationsss = [];
  List<Conversation>? Conversationsss1 = [];

  void GetAllConversation()async {
    // Dio_Helper.getData(url: 'conversations/$ID')
   await FirebaseFirestore.instance.collection('chats').get().then((value) {
      // all_Conversations = All_Conversation.fromJson(value.data)as List;
      value.docs.forEach((e) {
        all_Conversations?.add(Conversation.fromJson(e.data()));
        print('asda ${all_Conversations?.length}');
        GetConsaltant();
        //  // GetAllConsaltant();
        //   ///if down not work
        //   print('assssdsdsdda ${usermodel?.sId}');
        //   conversation = Conversation.fromJson(e.data());
        //   print('asda ${conversation?.sender?.SenderID}');
        //   if(conversation?.sender?.SenderID==usermodel?.sId){
        //     all_Conversations?.add(Conversation.fromJson(e.data()));
        //     print('asda ${all_Conversations?.length}');
        //     print('asda ${all_Conversations?[0].Id}');
        //     print('s');
        //   }
      });

      ///if up not work
      for (int i = 0; i < all_Conversations!.length; i++) {
        // print('assssdsdsdda ${all_Conversations?[i].sender?.SenderID}');
        // print('assssdsdsdda ${usermodel?.sId}');
        // print('assssdsdsdda ${FirebaseAuth.instance.currentUser?.uid}');
        if (all_Conversations?[i].sender?.SenderID == (usermodel?.sId??FirebaseAuth.instance.currentUser?.uid) ) {
          Conversationsss?.add(all_Conversations![i]);
          // print('asda ${all_Conversations?[i].sender?.SenderID}');
          // print('asda ${Conversationsss?.length}');
          // print('s');
        }
       // print('assssdsdsdda ${usermodel?.sId}');
        if (all_Conversations?[i].reciver?.reciverID == usermodel?.sId) {
          Conversationsss1?.add(all_Conversations![i]);
          // print('asdsa ${all_Conversations?[i].sender?.SenderID}');
          // print('asdsa ${Conversationsss1?.length}');
          // print('asdsa ${Conversationsss1?[i].reciver?.reciverID}');
          // print('s');
        }
      }
      emit(getAllConversationSucsesState());
    }).catchError((e) {
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

//message
  void sendNotification({
    required String fcmtoken,
    required String title,
    required String body,
    String? Image,
  }) {
    Dio_Helper.notification(data: {
      "to": fcmtoken,
      "notification": {"title": title, "body": body, "sound": "default"},
      "android": {
        "priority": "HIGH",
        "notification": {
          "notification_priority": "PRIORITY_MAX",
          "sound": "default",
          "default_sound": true,
          "default_vibrate_timings": true,
          "default_light_settings": true
        }
      },
      "data": {
        "text": body,
        "image": Image,
        "type": "order",
        "name": title,
        "id": "87",
        "click_action": "FLUTTER_NOTIFICATION_CLICK"
      }
    }).then((value) {
      emit(sendNotificationSucssesState());
    }).catchError((e) {
      emit(sendNotificationErrorState());
    });
  }
}
