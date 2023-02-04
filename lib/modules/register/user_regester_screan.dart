import 'package:buildcondition/buildcondition.dart';
import 'package:consultation/modules/login/login_screan1.dart';
import 'package:consultation/modules/register/consultant/consultant_register_screan.dart';
import 'package:consultation/modules/register/cubit/cubit.dart';
import 'package:consultation/modules/register/cubit/states.dart';
import 'package:consultation/shared/components/components.dart';
import 'package:consultation/shared/components/constens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/home_layout.dart';

class User_Regester_Screan extends StatelessWidget {
  var namecontroller = TextEditingController();
  var name2controller = TextEditingController();
  var emailcontroller = TextEditingController();
  var re_passcontroller = TextEditingController();
  var passcontroller = TextEditingController();
  String email = '';
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegesterCubit(),
      child: BlocConsumer<RegesterCubit, RegesterStates>(
        listener: (context, state) async{

          if (state is RegesterSucssesState) {
            UserID = await FirebaseAuth.instance.currentUser!.uid;
              ShowToast(text: 'تم التسجيل بنجاح', state: ToastState.SUCSSES);
                print('when register  =  $UserID');
                ShowToast(
                    text: 'مرحبا بك مجددا', state: ToastState.SUCSSES);
                navigateToAndFinish(context, Home_Layout());

          }
        },
        builder: (context, state) {
          var cubit = RegesterCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: Text(
                'إنشاء حساب',
                style: TextStyle(height: 3),
              ),
              centerTitle: true,
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'برجاء إدخال التفاصيل المطلوبة لعملية التسجيل',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          height: 2,
                          color: Colors.grey),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     defultButton(
                    //         text: 'مستخدم',
                    //         width: 120,
                    //         function: () {
                    //           cubit.changeUserRegister();
                    //           print(cubit.isUser);
                    //         },
                    //         radius: 0.0,
                    //         Background: cubit.isUser
                    //             ? Colors.blue
                    //             : Colors.grey.shade400),
                    //     defultButton(
                    //         text: 'مستشار',
                    //         radius: 0.0,
                    //         width: 120,
                    //         function: () {
                    //           cubit.changeUserRegister();
                    //           print(cubit.isUser);
                    //         },
                    //         Background: cubit.isUser
                    //             ? Colors.grey.shade400
                    //             : Colors.blue)
                    //   ],
                    // ),
                    SizedBox(
                      height: 30,
                    ),
                    if (cubit.isUser) User_regster(cubit, context, state),
                    if (!cubit.isUser)
                      consultant_regster(cubit, context, state),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget User_regster(RegesterCubit cubit, context, state) {
    var profileImage = RegesterCubit.get(context).profileimage;
    return Form(
      key: formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                CircleAvatar(
                  radius: 64,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: profileImage == null
                        ? NetworkImage(
                            'https://firebasestorage.googleapis.com/v0/b/consultant-359115.appspot.com/o/810-8105695_person-icon-grey-person-icon-grey-png.png?alt=media&token=32d90711-f96d-4f93-91d8-fc7c0c41cffa')
                        : FileImage(
                            profileImage,
                          ) as ImageProvider,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      RegesterCubit.get(context).getProfileImage();
                    },
                    icon: CircleAvatar(
                      radius: 20,
                      child: Icon(
                        Icons.camera,
                        size: 16,
                      ),
                    )),
              ],
            ),
          ),
          itemregister('الإسم'),
          defultFormField(
              type: TextInputType.name,
              controller: namecontroller,
              label: 'الإسم ',
              prefix: Icons.person,
              validator: (v) {
                if (v!.isEmpty) {
                  return 'من فضلك ادخل الاسم';
                }
              }),
          SizedBox(
            height: 20,
          ),
          itemregister('البريد الإلكتروني'),
          defultFormField(
              type: TextInputType.emailAddress,
              controller: emailcontroller,
              onChanged: (text) {
                email = text;
              },
              label: 'البريد الإلكتروني',
              prefix: Icons.email,
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return 'من فضلك ادخل البريد الاليكتروني';
                }
                if (!IsValidEmail(email)) {
                  return 'من فضلك ادخل بريد اليكتروني صالج';
                }
                return null;
              }),
          SizedBox(
            height: 20,
          ),
          itemregister('كلمة السر'),
          defultFormField(
              type: TextInputType.visiblePassword,
              controller: passcontroller,
              label: '*****************',
              suffix: cubit.suffix,
              isPassword: cubit.isPasword,
              passwordShow: () => cubit.changePasswordVisability(),
              prefix: Icons.lock,
              validator: (v) {
                RegExp regex = RegExp(
                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                if (v!.isEmpty) {
                  return 'من فضلك ادخل الباسورد';
                } else {
                  if (!regex.hasMatch(v)) {
                    return 'Password must be at least 8 characters,\n include an uppercase letter ,\n number and symbol like [@,#.*]';
                  } else {
                    return null;
                  }
                }
              }),
          SizedBox(
            height: 20,
          ),
          itemregister('إعادة إدخال كلمة السر'),
          defultFormField(
              type: TextInputType.visiblePassword,
              controller: re_passcontroller,
              label: '*****************',
              suffix: cubit.suffix,
              isPassword: cubit.isPasword,
              passwordShow: () => cubit.changePasswordVisability(),
              prefix: Icons.lock,
              validator: (v) {
                if (v != passcontroller.text) {
                  return 'الباسورد ليس متشايه';
                }
              }),
          SizedBox(
            height: 35,
          ),
          BuildCondition(
            condition: state is !RegesterLodingeState && state is !RegesterLoding_uploadImageState,
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
            builder: (context) => defultButton(
                text: 'تسجيل',
                function: () {
                  if (formkey.currentState!.validate()) {
                    cubit.UserRegister(
                      name: "${namecontroller.text} ",
                      email: emailcontroller.text,
                      password: passcontroller.text,
                      photo: profileImage
                    );
                  }
                },
                Background: Colors.red,
                radius: 13),
          ),
        ],
      ),
    );
  }

  Widget consultant_regster(RegesterCubit cubit, context, state) => Form(
        key: formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            itemregister('الإسم الأول'),
            defultFormField(
                type: TextInputType.name,
                controller: namecontroller,
                label: 'الإسم الأول  ',
                validator: (v) {
                  if (v!.isEmpty) {
                    return 'من فضلك ادخل الاسم الاول';
                  }
                }),
            SizedBox(
              height: 20,
            ),
            itemregister('الإسم الأخير'),
            defultFormField(
                type: TextInputType.name,
                controller: name2controller,
                label: 'الإسم الأخير  ',
                prefix: Icons.person,
                validator: (v) {
                  if (v!.isEmpty) {
                    return 'من فضلك ادخل الاسم الاخير';
                  }
                }),
            SizedBox(
              height: 20,
            ),
            itemregister('البريد الإلكتروني'),
            defultFormField(
                type: TextInputType.emailAddress,
                controller: emailcontroller,
                onChanged: (text) {
                  email = text;
                },
                label: 'البريد الإلكتروني',
                prefix: Icons.email,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return 'من فضلك ادخل البريد الاليكتروني';
                  }
                  if (!IsValidEmail(email)) {
                    return 'من فضلك ادخل بريد اليكتروني صالج';
                  }
                  return null;
                }),
            SizedBox(
              height: 20,
            ),
            itemregister('كلمة السر'),
            defultFormField(
                type: TextInputType.visiblePassword,
                controller: passcontroller,
                label: '*****************',
                suffix: cubit.suffix,
                isPassword: cubit.isPasword,
                passwordShow: () => cubit.changePasswordVisability(),
                prefix: Icons.lock,
                validator: (v) {
                  RegExp regex = RegExp(
                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                  if (v!.isEmpty) {
                    return 'من فضلك ادخل الباسورد';
                  } else {
                    if (!regex.hasMatch(v)) {
                      return 'Password must be at least 8 characters,\n include an uppercase letter ,\n number and symbol like [@,#.*]';
                    } else {
                      return null;
                    }
                  }
                }),
            SizedBox(
              height: 35,
            ),
            BuildCondition(
              condition: state is RegesterLodingeState && state is RegesterLoding_uploadImageState,
              fallback: (context) => Center(
                child: CircularProgressIndicator(),
              ),
              builder: (context) => defultButton(
                  text: 'التالي',
                  function: () {
                    if (formkey.currentState!.validate()) {
                      // cubit.consultRegister(
                      //     name:
                      //         "${namecontroller.text} " + name2controller.text,
                      //     email: emailcontroller.text,
                      //     password: passcontroller.text);
                    }
                  },
                  Background: Colors.red,
                  radius: 13),
            ),
          ],
        ),
      );
}
