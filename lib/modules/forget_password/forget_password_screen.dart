import 'package:buildcondition/buildcondition.dart';
import 'package:consultation/modules/login/cubit/cubit.dart';
import 'package:consultation/modules/login/cubit/states.dart';
import 'package:consultation/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Forget_Password extends StatelessWidget {
  var emailController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(' نسيت كلمة السر'),
            ),
            body: BuildCondition(
              condition: state is !LoginSucssesState,
              fallback: (context) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 40,),
                  Text('يرجي تفقد الايميل الخاص بك',
                    textAlign: TextAlign.center,style: TextStyle(
                      fontWeight: FontWeight.bold,
                 height: 3, color: Colors.black, fontSize: 20
                  ),)
                ],
              ),
              builder: (context) =>  Padding(
                 padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Text('يرجى ادخال الايميل الخاص بك',textAlign: TextAlign.end,style: TextStyle(
                        height: 3 ,fontSize: 16
                    )),
                    defultFormField(

                        type: TextInputType.text,
                        controller: emailController,
                        label: 'الايميل',
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'من فضلك ادخل الايميل';
                          }
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    BuildCondition(
                      condition: state is !LoginForgetLoginState,
                      fallback:(context) =>  Center(child: CircularProgressIndicator()),
                      builder: (context) =>defultButton(text: 'ارسل',
                          radius: 20,

                          function: (){
                        LoginCubit.get(context).forgetPassword(
                          email: emailController.text
                        );

                      }),
                    )
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
