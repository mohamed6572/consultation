import 'package:consultation/layout/cubit/cubit.dart';
import 'package:consultation/layout/cubit/states.dart';
import 'package:consultation/modules/change_password/change_password.dart';
import 'package:consultation/modules/edit_profile/edit_profile.dart';
import 'package:consultation/shared/components/components.dart';
import 'package:consultation/shared/components/constens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class settings extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        AppCubit.get(context).GetConsaltant();
        return BlocConsumer<AppCubit,AppStates>(
          listener: (context, state) {},
          builder: (context, state) {

            var cubit = AppCubit.get(context).usermodel;
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text('الاعدادات'),
              ),
              body: Column(
                children: [
                  if(cubit?.others?.country!=null||cubit?.others?.price!=null)
                    InkWell(
                      onTap: (){
                        navigateTo(context, Edit_Profile());
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('تعديل الملف الشخصي',style: TextStyle(fontSize: 18),),
                            Icon(Icons.arrow_forward_ios_outlined)
                          ],
                        ),
                      ),
                    ),
                  InkWell(
                    onTap: (){
                      navigateTo(context, change_password());

                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Text('تغيير الباسورد',style: TextStyle(fontSize: 18)),
                          Icon(Icons.arrow_forward_ios_outlined)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }
    );
  }


}
