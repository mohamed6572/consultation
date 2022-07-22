import 'package:consultation/modules/login/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit(): super(LoginInitialeState());

  static LoginCubit get(context) => BlocProvider.of(context);


  IconData suffix = Icons.visibility;
  bool isPasword = true;

  void changePasswordVisability(){
    isPasword = !isPasword;
    suffix = isPasword ? Icons.visibility : Icons.visibility_off;
    emit(LoginChangePasswordState());

  }


}