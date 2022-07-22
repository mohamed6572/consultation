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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(image: AssetImage('assets/images/logo.png')),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      'Login',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 26, height: 2),
                    ),
                    Text(
                      'Welcome back to your account',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          height: 2,
                          fontSize: 14,
                          color: Colors.grey),
                    ),
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
                        passwordShow: ()=>cubit.changePasswordVisability(),
                        prefix: Icons.lock,
                        validator: (v) {}),
                    Text('Forgot your password ?',style: TextStyle(height: 3,color: Colors.grey,fontSize: 13),),
                    SizedBox(
                      height: 10,
                    ),
                    defultButton(text: 'login', function: (){},Background: Colors.red,radius: 13),
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
                          ' or sign by ',
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
                        text: 'Login with Facebook',
                        logo: 'fac',
                        function: () {},
                        isUpperCase: false),
                    SizedBox(
                      height: 20,
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
