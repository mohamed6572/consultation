import 'package:consultation/modules/login/cubit/cubit.dart';
import 'package:consultation/modules/login/cubit/states.dart';
import 'package:consultation/modules/login/login_screan1.dart';
import 'package:consultation/modules/register/user_regester_screan.dart';
import 'package:consultation/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login_Screan extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
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
            defultButton(text: 'دخول', function: (){
              navigateTo(context, Login_Screan1());
            },Background: Colors.red,radius: 15),
            SizedBox(height: 30,),
            defultButton(text: 'تسجيل حساب جديد', function: (){
              navigateTo(context, User_Regester_Screan());
            },Background: Colors.blue,radius: 15),
            SizedBox(height: 30,),
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
            //       style: TextStyle(fontStyle: FontStyle.italic,color: Colors.grey.shade500),
            //     ),
            //     Expanded(
            //       child: Container(
            //         height: 0.5,
            //         color: Colors.grey.shade400,
            //       ),
            //     ),
            //   ],
            // ),
            // SizedBox(height: 30,),
            // authButton(text: 'Login with Google', logo: 'google_logo', function: (){},isUpperCase: false)
          ],
        ),
      ),
    );
  }
}
