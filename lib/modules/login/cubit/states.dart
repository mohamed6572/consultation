import 'package:consultation/models/LoginC_Model.dart';
import 'package:consultation/models/lgon_Model.dart';

abstract class LoginStates{}

class LoginInitialeState extends LoginStates{}
//user login
class LoginLodingeState extends LoginStates{}
class LoginSucssesState extends LoginStates{}
class LoginErrorState extends LoginStates{}
//consultant login
class LoginCLodingeState extends LoginStates{}
class LoginCSucssesState extends LoginStates{
  LoginC_Model? loginC_model;
  LoginCSucssesState(this.loginC_model);}
class LoginCErrorState extends LoginStates{}

class LoginChangeLoginState extends LoginStates{}
class LoginChangePasswordState extends LoginStates{}
//forget password
class LoginForgetLoginState extends LoginStates{}
class LoginForgetSucssesState extends LoginStates{}
class LoginForgetErrorState extends LoginStates{}