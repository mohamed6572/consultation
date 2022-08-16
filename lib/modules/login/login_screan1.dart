import 'package:buildcondition/buildcondition.dart';
import 'package:consultation/layout/home_layout.dart';
import 'package:consultation/modules/login/cubit/cubit.dart';
import 'package:consultation/modules/login/cubit/states.dart';
import 'package:consultation/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:consultation/shared/network/local/cash_helper.dart';

import '../../layout/homeU_layout.dart';

class Login_Screan1 extends StatelessWidget {
  var emailcontroller = TextEditingController();
  var passcontroller = TextEditingController();

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          // if (state.login_model.status) {
          //   ShowToast(
          //       text: state.login_model.message!, state: ToastState.SUCSSES);
          //   cash_helper
          //       .saveData(key: 'token', value: state.login_model.data?.token)
          //       .then((value) {
          //     navigateToAndFinish(context, Home_Layout());
          //   });
          // } else {
          //   ShowToast(
          //       text: state.login_model.message!, state: ToastState.ERROR);
          // }


          if (state is LoginSucssesState) {
            cash_helper
                .saveData(key: 'token', value: state.login_model.accessToken)
                .then((value) {
              navigateToAndFinish(context, HomeU_Layout());
            });
          }
          if (state is LoginCSucssesState) {
            if (state.loginC_model!.status!) {
              cash_helper
                  .saveData(key: 'ID', value: state.loginC_model?.sId)
                  .then((value) {});
              cash_helper
                  .saveData(
                  key: 'token', value: state.loginC_model?.accessToken)
                  .then((value) {
                navigateToAndFinish(context, Home_Layout());
              });
            }else{
              ShowToast(
                  text: state.loginC_model!.message!, state: ToastState.ERROR);
            }
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          defultButton(
                              text: 'مستخدم',
                              width: 120,
                              function: () {
                                cubit.changeUserLogin();
                                print(cubit.isUser);
                              },
                              radius: 0.0,
                              Background: cubit.isUser
                                  ? Colors.blue
                                  : Colors.grey.shade400),
                          defultButton(
                              text: 'مستشار',
                              radius: 0.0,
                              width: 120,
                              function: () {
                                cubit.changeUserLogin();
                                print(cubit.isUser);
                              },
                              Background: cubit.isUser
                                  ? Colors.grey.shade400
                                  : Colors.blue)
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      if (cubit.isUser) LoginUser(cubit, context,state),
                      if (!cubit.isUser) LoginConsultant(cubit, context,state),

                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  Widget LoginConsultant(LoginCubit cubit , context , state) => Column(
    children: [
      Text(
        'مرحبا مجددا لحسابك ايها المستشار',
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
      Text(
        'هل نسيت كلمة السر ؟',
        textAlign: TextAlign.end,
        style: TextStyle(
            height: 3, color: Colors.grey, fontSize: 13),
      ),
      SizedBox(
        height: 10,
      ),

      BuildCondition(
        condition: state is! LoginCLodingeState,
        fallback: (context) => Center(child: CircularProgressIndicator(),),
        builder:(context) =>   defultButton(
            text: 'دخول',
            function: () {
              if (formkey.currentState!.validate()) {
                cubit.ConsultantLogin(
                    email: emailcontroller.text,
                    password: passcontroller.text);
              }
            },
            Background: Colors.red,
            radius: 13),
      ),
      // SizedBox(
      //   height: 30,
      // ),
      // Row(
      //   children: [
      //     Expanded(
      //       child: Container(
      //         height: 0.5,
      //         color: Colors.grey.shade400,
      //       ),
      //     ),
      //     Text(
      //       ' أو سجل بواسطة ',
      //       style: TextStyle(
      //           fontStyle: FontStyle.italic,
      //           color: Colors.grey.shade500),
      //     ),
      //     Expanded(
      //       child: Container(
      //         height: 0.5,
      //         color: Colors.grey.shade400,
      //       ),
      //     ),
      //   ],
      // ),
      // SizedBox(
      //   height: 30,
      // ),
      // authButton(
      //     text: 'Login with Google',
      //     logo: 'google_logo',
      //     function: () {},
      //     isUpperCase: false)
    ],
  );
  Widget LoginUser(LoginCubit cubit , context , state) => Column(
    children: [
      Text(
        'مرحبا مجددا لحسابك ايها المستخدم',
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
      Text(
        'هل نسيت كلمة السر ؟',
        textAlign: TextAlign.end,
        style: TextStyle(
            height: 3, color: Colors.grey, fontSize: 13),
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
      // SizedBox(
      //   height: 30,
      // ),
      // Row(
      //   children: [
      //     Expanded(
      //       child: Container(
      //         height: 0.5,
      //         color: Colors.grey.shade400,
      //       ),
      //     ),
      //     Text(
      //       ' أو سجل بواسطة ',
      //       style: TextStyle(
      //           fontStyle: FontStyle.italic,
      //           color: Colors.grey.shade500),
      //     ),
      //     Expanded(
      //       child: Container(
      //         height: 0.5,
      //         color: Colors.grey.shade400,
      //       ),
      //     ),
      //   ],
      // ),
      // SizedBox(
      //   height: 30,
      // ),
      // authButton(
      //     text: 'Login with Google',
      //     logo: 'google_logo',
      //     function: () {},
      //     isUpperCase: false)
    ],
  );
}
