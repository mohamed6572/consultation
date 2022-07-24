import 'package:consultation/modules/register/consultant/consultant_register_screan.dart';
import 'package:consultation/modules/register/cubit/cubit.dart';
import 'package:consultation/modules/register/cubit/states.dart';
import 'package:consultation/shared/components/components.dart';
import 'package:consultation/shared/components/constens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class User_Regester_Screan extends StatelessWidget {
  var namecontroller = TextEditingController();
  var name2controller = TextEditingController();
  var emailcontroller = TextEditingController();
  var re_passcontroller = TextEditingController();
  var passcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegesterCubit(),
      child: BlocConsumer<RegesterCubit, RegesterStates>(
        listener: (context, state) {},
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        defultButton(
                            text: 'مستخدم',
                            width: 120,
                            function: () {
                              cubit.changeUserRegister();
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
                              cubit.changeUserRegister();
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
                    if (cubit.isUser) User_regster(cubit, context),
                    if (!cubit.isUser) consultant_regster(cubit, context),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget User_regster(cubit, context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          itemregister('الإسم'),
          defultFormField(
              type: TextInputType.name,
              controller: namecontroller,
              label: 'الإسم ',
              prefix: Icons.person,
              validator: (v) {}),
          SizedBox(
            height: 20,
          ),
          itemregister('البريد الإلكتروني'),
          defultFormField(
              type: TextInputType.emailAddress,
              controller: emailcontroller,
              label: 'البريد الإلكتروني',
              prefix: Icons.email,
              validator: (v) {}),
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
              validator: (v) {}),
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
              validator: (v) {}),
          SizedBox(
            height: 35,
          ),
          defultButton(
              text: 'تسجيل',
              function: () {},
              Background: Colors.red,
              radius: 13),
        ],
      );

  Widget consultant_regster(cubit, context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          itemregister('الإسم الأول'),
          defultFormField(
              type: TextInputType.name,
              controller: namecontroller,
              label: 'الإسم الأول  ',
              validator: (v) {}),
          SizedBox(
            height: 20,
          ),
          itemregister('الإسم الأخير'),
          defultFormField(
              type: TextInputType.name,
              controller: name2controller,
              label: 'الإسم الأخير  ',
              prefix: Icons.person,
              validator: (v) {}),
          SizedBox(
            height: 20,
          ),
          itemregister('البريد الإلكتروني'),
          defultFormField(
              type: TextInputType.emailAddress,
              controller: emailcontroller,
              label: 'البريد الإلكتروني',
              prefix: Icons.email,
              validator: (v) {}),
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
              validator: (v) {}),

          SizedBox(
            height: 35,
          ),
          defultButton(
              text: 'التالي',
              function: () {
                navigateTo(context, Consultant_Register_Screan());
              },
              Background: Colors.red,
              radius: 13),
        ],
      );
}
