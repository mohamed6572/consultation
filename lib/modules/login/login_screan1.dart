import 'package:consultation/modules/login/cubit/cubit.dart';
import 'package:consultation/modules/login/cubit/states.dart';
import 'package:consultation/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login_Screan1 extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(image: AssetImage('assets/images/logo1.png')),
                  SizedBox(height: 100,),
                  defultButton(text: 'login', function: (){},Background: Colors.red,radius: 15),
                  SizedBox(height: 30,),
                  defultButton(text: 'signup', function: (){},Background: Colors.blue,radius: 15),
                  SizedBox(height: 30,),
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
                        style: TextStyle(fontStyle: FontStyle.italic,color: Colors.grey.shade500),
                      ),
                      Expanded(
                        child: Container(
                          height: 0.5,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30,),
                  authButton(text: 'Login with Facebook', logo: 'fac', function: (){},isUpperCase: false),
                  SizedBox(height: 20,),
                  authButton(text: 'Login with Google', logo: 'google_logo', function: (){},isUpperCase: false)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
