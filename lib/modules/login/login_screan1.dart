import 'package:consultation/modules/login/cubit/cubit.dart';
import 'package:consultation/modules/login/cubit/states.dart';
import 'package:consultation/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login_Screan1 extends StatelessWidget {
  var emailcontroller = TextEditingController();
  var passcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {},
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
                          fontWeight: FontWeight.w500, fontSize: 26, height: 2),
                    ),
                    Text(
                      'مرحبا مجددا لحسابك',
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
                        validator: (v) {}),
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
                        validator: (v) {}),
                    Text(
                      'هل نسيت كلمة السر ؟',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          height: 3, color: Colors.grey, fontSize: 13),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    defultButton(
                        text: 'دخول',
                        function: () {},
                        Background: Colors.red,
                        radius: 13),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 0.5,
                            color: Colors.grey.shade400,
                          ),
                        ),
                        Text(
                          ' أو سجل بواسطة ',
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.grey.shade500),
                        ),
                        Expanded(
                          child: Container(
                            height: 0.5,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    authButton(
                        text: 'Login with Google',
                        logo: 'google_logo',
                        function: () {},
                        isUpperCase: false)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
