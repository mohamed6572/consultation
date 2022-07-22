import 'package:consultation/modules/register/consultant/consultant_register_screan.dart';
import 'package:consultation/modules/register/cubit/cubit.dart';
import 'package:consultation/modules/register/cubit/states.dart';
import 'package:consultation/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class User_Regester_Screan extends StatelessWidget {
  var namecontroller = TextEditingController();
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
                'SignUp',
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
                      height: 50,
                    ),
                    Text(
                      'Please enter the required details for the registration process',
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
                            text: 'User',
                            width: 120,
                            function: () {
                              cubit.changeUserRegister();
                              print(cubit.isUser);
                            },
                            radius: 0.0,
                            Background: cubit.isUser ?Colors.blue : Colors.grey),
                        defultButton(
                            text: 'Consultant',
                            radius: 0.0,
                            width: 120,
                            function: () {
                              cubit.changeUserRegister();
                              print(cubit.isUser);
                            },
                            Background:  cubit.isUser ?  Colors.grey:Colors.blue)
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    if (cubit.isUser) User_regster(cubit,context),
                    if (!cubit.isUser) consultant_regster(cubit,context),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget User_regster(cubit,context) => Column(
        children: [
          defultFormField(
              type: TextInputType.name,
              controller: namecontroller,
              label: 'Name',
              prefix: Icons.person,
              validator: (v) {}),
          SizedBox(
            height: 30,
          ),
          defultFormField(
              type: TextInputType.emailAddress,
              controller: emailcontroller,
              label: 'E-mail',
              prefix: Icons.email,
              validator: (v) {}),
          SizedBox(
            height: 30,
          ),
          defultFormField(
              type: TextInputType.visiblePassword,
              controller: passcontroller,
              label: 'password',
              suffix: cubit.suffix,
              isPassword: cubit.isPasword,
              passwordShow: () => cubit.changePasswordVisability(),
              prefix: Icons.lock,
              validator: (v) {}),
          SizedBox(
            height: 30,
          ),
          defultFormField(
              type: TextInputType.visiblePassword,
              controller: re_passcontroller,
              label: 'Re-enter password',
              suffix: cubit.suffix,
              isPassword: cubit.isPasword,
              passwordShow: () => cubit.changePasswordVisability(),
              prefix: Icons.lock,
              validator: (v) {}),
          SizedBox(
            height: 35,
          ),
          defultButton(
              text: 'SignUp',
              function: () {},
              Background: Colors.red,
              radius: 13),
        ],
      );
  Widget consultant_regster(cubit,context) => Column(
        children: [
          defultFormField(
              type: TextInputType.name,
              controller: namecontroller,
              label: 'Name',
              prefix: Icons.person,
              validator: (v) {}),
          SizedBox(
            height: 30,
          ),
          defultFormField(
              type: TextInputType.emailAddress,
              controller: emailcontroller,
              label: 'E-mail',
              prefix: Icons.email,
              validator: (v) {}),
          SizedBox(
            height: 30,
          ),
          defultFormField(
              type: TextInputType.visiblePassword,
              controller: passcontroller,
              label: 'password',
              suffix: cubit.suffix,
              isPassword: cubit.isPasword,
              passwordShow: () => cubit.changePasswordVisability(),
              prefix: Icons.lock,
              validator: (v) {}),
          SizedBox(
            height: 30,
          ),
          defultFormField(
              type: TextInputType.visiblePassword,
              controller: re_passcontroller,
              label: 'Re-enter password',
              suffix: cubit.suffix,
              isPassword: cubit.isPasword,
              passwordShow: () => cubit.changePasswordVisability(),
              prefix: Icons.lock,
              validator: (v) {}),
          SizedBox(
            height: 35,
          ),
          defultButton(
              text: 'following',
              function: () {
                navigateTo(context, Consultant_Register_Screan());
              },
              Background: Colors.red,
              radius: 13),
        ],
      );
}
