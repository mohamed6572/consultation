import 'dart:io';

import 'package:buildcondition/buildcondition.dart';
import 'package:consultation/layout/cubit/cubit.dart';
import 'package:consultation/layout/cubit/states.dart';
import 'package:consultation/layout/home_layout.dart';
import 'package:consultation/shared/components/components.dart';
import 'package:consultation/shared/components/constens.dart';
import 'package:consultation/shared/styles/colors.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Edit_Profile extends StatelessWidget{
  var phonecontroller = TextEditingController();
  var namecontroller = TextEditingController();
  var countrycontroller = TextEditingController();
  var costcontroller = TextEditingController();
  var discripcontroller = TextEditingController();
  var qualificationcontroller = TextEditingController();
  var EXcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        AppCubit.get(context)..GetConsaltant();
        return BlocConsumer<AppCubit,AppStates>(
          listener: (context, state) {
            if(state is UpdateSuccsessState){
              AppCubit.get(context).GetConsaltant();
              navigateTo(context, Home_Layout());
            }

          },
          builder:(context, state) {
          var editImage = AppCubit.get(context).editprofileimage;
          var cubit =AppCubit.get(context);
          var CVimage =AppCubit.get(context).CVimage;
          var model =AppCubit.get(context).usermodel;
         namecontroller.text ="${model?.username??""}"  ;
          phonecontroller.text ="${model?.phone??""}"  ;
          countrycontroller.text =model?.country ??'' ;
          costcontroller.text ="${model?.price??""}"  ;
          discripcontroller.text =model?.about ??'' ;
          qualificationcontroller.text =model?.qualification ??'' ;
         EXcontroller.text ='${model?.EX??'0'}'  ;
          return
            Scaffold(
              appBar: AppBar(
                title:
                Text('تعديل المعلومات'),
                centerTitle: true,
                actions: [
                defultTextButtton(text: 'تعديل', function: () {
                  cubit.UpdateConsaltant(
                      About: discripcontroller.text,
                      price: costcontroller.text,
                      phone: phonecontroller.text,
                      country: countrycontroller.text,
                      qualification: qualificationcontroller.text,
                      counseling: cubit.selectedValue==null ? model!.counseling!:cubit.selectedValue! ,
                      name: namecontroller.text,
                      EX: int.parse(EXcontroller.text)
                  );
         }),
                  SizedBox(width: 10,)
                ],
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if(state is UpdateLodingState)
                      LinearProgressIndicator(),
                      if(state is UpdateLodingState)
                        SizedBox(
                          height: 10,
                        ),
                      itemregister('إرفاق الشهادة صورة'),
                      Container(
                        height: 230,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Align(
                              alignment: AlignmentDirectional.topEnd,
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 160,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(4.0),
                                          topLeft: Radius.circular(4.0),
                                        ),
                                        image: DecorationImage(

                                            image: CVimage ==null ?
                                            NetworkImage(
                                              '${model?.cVPhoto??'https://image.shutterstock.com/image-vector/upload-icon-flat-vector-download-260nw-1378175036.jpg'}',

                                            ): FileImage(CVimage) as ImageProvider,
                                            fit: BoxFit.fill)),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        cubit.getCVImage();
                                      },
                                      icon: CircleAvatar(
                                        radius: 20,
                                        child: Icon(
                                          Icons.camera_alt_outlined,
                                          size: 16,
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                CircleAvatar(
                                  radius: 64,
                                  backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                                  child: CircleAvatar(
                                    radius: 60,
                                    backgroundImage: editImage == null
                                        ? NetworkImage('${model?.profilePicture??'https://firebasestorage.googleapis.com/v0/b/consultant-359115.appspot.com/o/810-8105695_person-icon-grey-person-icon-grey-png.png?alt=media&token=32d90711-f96d-4f93-91d8-fc7c0c41cffa'}')
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
                                        Icons.camera_alt_outlined,
                                        size: 16,
                                      ),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      if(editImage !=null || CVimage != null)
                        Row(
                          children: [
                            if(editImage !=null)
                              Expanded(child: Column(
                                children: [
                                  defultButton(text: 'الصورة الشخصية', function: (){
                                    cubit.uploadProfileImage(
                                        About: discripcontroller.text,
                                        price: costcontroller.text,
                                        phone: phonecontroller.text,
                                        country: countrycontroller.text,
                                        qualification: qualificationcontroller.text,
                                        counseling: cubit.selectedValue==null ? model!.counseling!:cubit.selectedValue! ,
                                        name: namecontroller.text,
                                        EX: int.parse(EXcontroller.text)
                                    );
                                  }),
                                  SizedBox(height: 5,),
                                  if(state is UpdateLodingState)

                                    LinearProgressIndicator(),

                                ],
                              )),
                            SizedBox(width: 5,),
                            if(CVimage !=null)
                              Expanded(child:
                              Column(
                                children: [
                                  defultButton(text: 'الشهادة', function: (){
                                    cubit.uploadCVImage(
                                        About: discripcontroller.text,
                                        price: costcontroller.text,
                                        phone: phonecontroller.text,
                                        country: countrycontroller.text,
                                        qualification: qualificationcontroller.text,
                                        counseling: cubit.selectedValue==null ? model!.counseling!:cubit.selectedValue! ,
                                        name: namecontroller.text,
                                        EX: int.parse(EXcontroller.text)
                                    );
                                  }),
                                  SizedBox(height: 5,),
                                  if(state is Update_CV_LodingState)

                                    LinearProgressIndicator(),

                                ],
                              )),
                          ],
                        ),
                      if(editImage !=null || CVimage != null)
                        SizedBox(
                          height: 20,
                        ),
                      // ////////////////
                      // if(state is UpdateLodingState)
                      //   LinearProgressIndicator(),
                      //
                      // Center(
                      //   child: Stack(
                      //     alignment: AlignmentDirectional.bottomEnd,
                      //     children: [
                      //       CircleAvatar(
                      //         radius: 64,
                      //         backgroundColor:
                      //         Theme.of(context).scaffoldBackgroundColor,
                      //         child: CircleAvatar(
                      //           radius: 60,
                      //           backgroundImage: editImage == null
                      //               ? NetworkImage('${model?.profilePicture??'https://firebasestorage.googleapis.com/v0/b/consultant-359115.appspot.com/o/810-8105695_person-icon-grey-person-icon-grey-png.png?alt=media&token=32d90711-f96d-4f93-91d8-fc7c0c41cffa'}')
                      //               : FileImage(
                      //             editImage,
                      //           ) as ImageProvider,
                      //         ),
                      //       ),
                      //       IconButton(
                      //           onPressed: () {
                      //             cubit.getEditProfileImage();
                      //           },
                      //           icon: CircleAvatar(
                      //             radius: 20,
                      //             child: Icon(
                      //               Icons.camera,
                      //               size: 16,
                      //             ),
                      //           )),
                      //     ],
                      //   ),
                      // ),
                      // /////////////////////////////
                      // SizedBox(
                      //   height: 20,
                      // ),
                      itemregister('الاسم'),
                      defultFormField(
                          suffix: Icons.edit,
                          type: TextInputType.text,
                          controller: namecontroller,
                          label: 'الاسم',
                          validator: (v) {}),
                      SizedBox(
                        height: 20,
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
                        height: 20,
                      ),
                      itemregister('المؤهل'),
                      defultFormField(
                          maxlines: 2,
                          type: TextInputType.text,
                          controller: qualificationcontroller,
                          label: 'حاصل علي ....',
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'من فضلك ادخل المؤهل';
                            }
                          }),
                      SizedBox(
                        height: 30,
                      ),
                      itemregister('ما نوع الاستشارة التي ستقدمها'),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            border: Border.all(color: Colors.black54, width: 1),
                            borderRadius: BorderRadius.circular(13)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: DropdownButtonHideUnderline(
                                    child: ButtonTheme(
                                      alignedDropdown: true,
                                      child: DropdownButton<dynamic>(
                                        hint:model?.counseling==null? Text(
                                            'اختار نوع الاستشارة التي ستقدمها '):Text(
                                            '${model?.counseling??'اختار نوع الاستشارة التي ستقدمها '}'),
                                        value: cubit.selectedValue,
                                        onChanged: (value) {
                                          cubit.changeSelected(value);
                                        },
                                        items: cubit.items.map((e) {
                                          return DropdownMenuItem(
                                              value: e['name'].toString(),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .end,
                                                children: [
                                                  Image.asset(
                                                    e['image'],
                                                    width: 25,
                                                  ),
                                                  // Image(image: AssetImage(e['image']),width: 25,),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 15),
                                                    child: Text(e['name']),
                                                  )
                                                ],
                                              ));
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      itemregister('مدة الخبرة'),
                      defultFormField(
                          maxlines: 1,
                          type: TextInputType.number,
                          controller: EXcontroller,
                          label: 'مدة الخبرة',
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'من فضلك ادخل مدة الخبرة';
                            }
                          }),


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
