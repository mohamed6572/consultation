import 'dart:io';

import 'package:buildcondition/buildcondition.dart';
import 'package:consultation/layout/cubit/cubit.dart';
import 'package:consultation/layout/cubit/states.dart';
import 'package:consultation/shared/components/components.dart';
import 'package:consultation/shared/components/constens.dart';
import 'package:consultation/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Edit_Profile extends StatelessWidget{
  var phonecontroller = TextEditingController();
  var countrycontroller = TextEditingController();
  var costcontroller = TextEditingController();
  var discripcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        AppCubit.get(context)..GetConsaltant()..GetAllConsaltant();
        return BlocConsumer<AppCubit,AppStates>(
          listener: (context, state) {

          },
          builder:(context, state) {
          var editImage = AppCubit.get(context).editprofileimage;
          var cubit =AppCubit.get(context);
          var model =AppCubit.get(context).usermodel;
          phonecontroller.text ="${model?.others?.phone}"  ;
          countrycontroller.text =model?.others?.country ??'' ;
          costcontroller.text ="${model?.others?.price}"  ;
          discripcontroller.text =model?.others?.about ??'' ;
          return
            Scaffold(
              appBar: AppBar(
                title:
                Text('تعديل المعلومات'),
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if(state is UpdateLodingState)
                        LinearProgressIndicator(),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 64,
                              backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: editImage == null
                                    ? NetworkImage('${model?.others?.profilePicture}')
                                    : FileImage(
                                  editImage,
                                ) as ImageProvider,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  cubit.getEditProfileImage();
                                },
                                icon: CircleAvatar(
                                  radius: 20,
                                  child: Icon(
                                    Icons.camera,
                                    size: 16,
                                  ),
                                )),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      itemregister('رقم الهاتف '),
                      defultFormField(
                          suffix: Icons.edit,

                          type: TextInputType.text,
                          controller: phonecontroller,
                          label: '0000000000+',
                          validator: (v) {}),
                      SizedBox(
                        height: 20,
                      ),
                      itemregister('البلد'),
                      defultFormField(
                          suffix: Icons.edit,

                          type: TextInputType.text,
                          controller: countrycontroller,
                          label: 'البلد',
                          validator: (v) {}),
                      SizedBox(
                        height: 20,
                      ),
                      itemregister('سعر الخدمة'),

                      defultFormField(
                          suffix: Icons.edit,

                          type: TextInputType.number,
                          controller: costcontroller,
                          label: 'السعر',
                          validator: (v) {}),
                      SizedBox(
                        height: 20,
                      ),
                      itemregister('نبذة عن أعمالك'),

                      defultFormField(
                          suffix: Icons.edit,
                          maxlines: 4,
                          type: TextInputType.text,
                          controller: discripcontroller,
                          label: 'نبذة عن أعمالك',
                          validator: (v) {}),

                      SizedBox(
                        height: 40,
                      ),
                      defultButton(
                          text: 'تعديل',
                          function: () {
                            if(editImage!=null){
                              cubit.UpdateConsultantImage(
                                  About: discripcontroller.text,
                                  price: costcontroller.text,
                                  phone: phonecontroller.text,
                                  country: countrycontroller.text,
                                  profilePicture: editImage
                              );
                            }else{
                              cubit.UpdateConsaltant(
                                  About: discripcontroller.text,
                                  price: costcontroller.text,
                                  phone: phonecontroller.text,
                                  country: countrycontroller.text
                              );}
                          },
                          width: 120,

                          Background: defColor,
                          radius: 13),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            );

        },  );
      }
    );
  }
}
