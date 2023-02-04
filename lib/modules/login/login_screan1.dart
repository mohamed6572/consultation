import 'package:buildcondition/buildcondition.dart';
import 'package:consultation/layout/home_layout.dart';
import 'package:consultation/modules/forget_password/forget_password_screen.dart';
import 'package:consultation/modules/login/cubit/cubit.dart';
import 'package:consultation/modules/login/cubit/states.dart';
import 'package:consultation/shared/components/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:consultation/shared/network/local/cash_helper.dart';

import '../../layout/homeU_layout.dart';
import '../../shared/components/constens.dart';

class Login_Screan1 extends StatelessWidget {
  var emailcontroller = TextEditingController();
  var passcontroller = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state)async {
        if (state is LoginSucssesState) {
           UserID = await FirebaseAuth.instance.currentUser!.uid;
           print('when login  =  $UserID');
          ShowToast(
              text: 'مرحبا بك مجددا', state: ToastState.SUCSSES);
          navigateToAndFinish(context, Home_Layout());
        }
      },
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image(
                      image: AssetImage('assets/images/logo.png'),
                      height: 90,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      'تسجيل الدخول',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 26,
                          height: 2),
                    ),

                    Text(
                      'مرحبا مجددا لحسابك ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          height: 2,
                          fontSize: 14,
                          color: Colors.grey),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        'حسابك',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SizedBox(
                      height: 9,
                    ),
                    defultFormField(
                        type: TextInputType.emailAddress,
                        controller: emailcontroller,
                        label: 'E-mail',
                        prefix: Icons.email,
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'من فضلك ادخل البريد الاليكتروني';
                          }
                        }),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        'كلمة السر',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SizedBox(
                      height: 9,
                    ),
                    defultFormField(
                        type: TextInputType.visiblePassword,
                        controller: passcontroller,
                        label: '*****************',
                        suffix: cubit.suffix,
                        isPassword: cubit.isPasword,
                        passwordShow: () => cubit.changePasswordVisability(),
                        prefix: Icons.lock,
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'من فضلك ادخل الباسورد';
                          }
                        }),
                    Align(
                      alignment: Alignment.topRight,
                      child: defultTextButtton(text:  'هل نسيت كلمة السر ؟', function: (){
                        navigateTo(context, Forget_Password());
                      }),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    BuildCondition(
                      condition: state is! LoginLodingeState,
                      fallback: (context) => Center(child: CircularProgressIndicator(),),
                      builder:(context) =>   defultButton(
                          text: 'دخول',
                          function: () {
                            if (formkey.currentState!.validate()) {
                              cubit.UserLogin(
                                  email: emailcontroller.text,
                                  password: passcontroller.text);
                            }
                          },
                          Background: Colors.red,
                          radius: 13),
                    ),
                    //


                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
