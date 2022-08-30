import 'package:consultation/models/LoginC_Model.dart';
import 'package:consultation/models/lgon_Model.dart';
import 'package:consultation/modules/login/cubit/states.dart';
import 'package:consultation/shared/components/constens.dart';
import 'package:consultation/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/network/end_points.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialeState());

  static LoginCubit get(context) => BlocProvider.of(context);

  late Login_Model login_model;

  void UserLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLodingeState());

    Dio_Helper.postData(
      url: LOGINU,
      data: {
        "email": email,
        "password": password,
      },
    ).then((value) {
      print(value.data);
      login_model = Login_Model.fromJson(value.data);
      print(login_model.email);
      emit(LoginSucssesState(login_model));
    }).catchError((e) {
      print(e.toString());
      emit(LoginErrorState());
    });
  }
  LoginC_Model? loginC_Model;
  void
  ConsultantLogin({
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
      print(value.data);
      loginC_Model = LoginC_Model.fromJson(value.data);
      print(loginC_Model?.email);
      print(loginC_Model?.country);
      print(loginC_Model?.phone);
      print(loginC_Model?.username);
      print(loginC_Model?.counseling);
      emit(LoginCSucssesState(loginC_Model));
      print('dioooo is => ${Dio_Helper. dio.httpClientAdapter.hashCode}');
    }).catchError((e) {
      print(e.toString());
      print('dioooo is => ${Dio_Helper. dio.httpClientAdapter.hashCode}');

      emit(LoginCErrorState());
    });
  }
//forget password
  void forgetPassword({
  required String email
}){
    emit(LoginForgetLoginState());
    Dio_Helper.Forgetpassword(data:
    {
      "email":email
    }
    ).then((value) {
      emit(LoginForgetSucssesState());
    }).catchError((e){
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

  void changeUserLogin(){
    isUser = !isUser;
    emit(LoginChangeLoginState());

  }
}
