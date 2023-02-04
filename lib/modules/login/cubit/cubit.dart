import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation/models/LoginC_Model.dart';
import 'package:consultation/models/lgon_Model.dart';
import 'package:consultation/modules/login/cubit/states.dart';
import 'package:consultation/shared/components/constens.dart';
import 'package:consultation/shared/network/remote/dio_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../models/consultant_model.dart';
import '../../../models/user_model.dart';
import '../../../shared/components/components.dart';
import '../../../shared/network/end_points.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialeState());

  static LoginCubit get(context) => BlocProvider.of(context);


  void UserLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLodingeState());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
      emit(LoginSucssesState());

      print(value.user?.uid);

    }).catchError((e) {
      print('when login $e');
      ShowToast(
          text: 'يرجى مراجعه البيانات', state: ToastState.ERROR);

      emit(LoginErrorState());
    });
  }



  void signInWithGoogle(context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) async{
      ///to make last seen
      try {
        // Fetch sign-in methods for the email address
        final list =
            await FirebaseAuth.instance.fetchSignInMethodsForEmail(value.user!.email!);
        // In case list is not empty
        if (list.isNotEmpty) {

          // user using the email address
         // UserID=value.user!.uid;
          emit(LoginSucssesState());
        } else {
          model = Consultant_Model(
             username: value.user?.displayName,
              email: value.user?.email,
              sId: value.user?.uid,
              profilePicture: value.user?.photoURL,
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
         // UserID=value.user!.uid;
          FirebaseFirestore.instance.collection('users').doc(value.user?.uid).set(model!.toJson());
          emit(LoginSucssesState());
        }
      } catch (e) {
        print('when fetching emails $e');

      }
      print(value.user?.metadata.lastSignInTime);


    }).catchError((e){
      print('when google signIn $e');
      emit(LoginErrorState());
    });

  }

  LoginC_Model? loginC_Model;

  void ConsultantLogin({
    required String email,
    required String password,
  }) {
    emit(LoginCLodingeState());

    Dio_Helper.postData(
      url: LOGINC,
      data: {
        "email": email,
        "password": password,
      },
    ).then((value) {
      emit(LoginCSucssesState(loginC_Model));
      print('dioooo is => ${Dio_Helper.dio.httpClientAdapter.hashCode}');
    }).catchError((e) {
      print(e.toString());
      print('dioooo is => ${Dio_Helper.dio.httpClientAdapter.hashCode}');

      emit(LoginCErrorState());
    });
  }
//forget password
  void forgetPassword({required String email})async {
    emit(LoginForgetLoginState());
    //api
    //Dio_Helper.Forgetpassword(data: {"email": email})
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email ).then((value) {
      emit(LoginForgetSucssesState());
      ShowToast(
          text: 'تم ارسال لينك تغيير الباسورد', state: ToastState.SUCSSES);
    }).catchError((e) {
      print(e.toString());
      ShowToast(
          text: 'يوجد مشكله', state: ToastState.ERROR);
      emit(LoginForgetErrorState());
    });
  }

  IconData suffix = Icons.visibility;
  bool isPasword = true;
  bool isUser = true;

  void changePasswordVisability() {
    isPasword = !isPasword;
    suffix = isPasword ? Icons.visibility : Icons.visibility_off;
    emit(LoginChangePasswordState());
  }

  void changeUserLogin() {
    isUser = !isUser;
    emit(LoginChangeLoginState());
  }
}
