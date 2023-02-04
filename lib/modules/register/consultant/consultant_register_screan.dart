import 'package:buildcondition/buildcondition.dart';
import 'package:consultation/modules/register/consultant/consultant_register_screan1.dart';
import 'package:consultation/modules/register/cubit/cubit.dart';
import 'package:consultation/modules/register/cubit/states.dart';
import 'package:consultation/shared/components/components.dart';
import 'package:consultation/shared/components/constens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Consultant_Register_Screan extends StatelessWidget {
  var qualificationcontroller = TextEditingController();
  var durationcontroller = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegesterCubit(),
      child: BlocConsumer<RegesterCubit, RegesterStates>(
        listener: (context, state) {
          if (state is RegesterCUpdateSucssesState)
            navigateTo(context, Consultant_Register_Screan1());
        },
        builder: (context, state) {
          var CVImage = RegesterCubit
              .get(context)
              .CVimage;
          var cubit = RegesterCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'تابع تسجيل دخولك',
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
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                    SizedBox(
                    height: 40,
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
                                    hint: Text(
                                        'اختار نوع الاستشارة التي ستقدمها '),
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
                      maxlines: 2,
                      type: TextInputType.text,
                      controller: durationcontroller,
                      label: 'مدة الخبرة',
                      validator: (v) {
                        if (v!.isEmpty) {
                          return 'من فضلك ادخل مدة الخبرة';
                        }
                      }),
                  SizedBox(
                    height: 25,
                  ),
                  itemregister('إرفاق الشهادة صورة'),
                  Center(
                    child: Container(
                      height: 140,
                      width: double.infinity,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          Image(image: CVImage == null
                              ? NetworkImage(
                              'https://image.shutterstock.com/image-vector/upload-icon-flat-vector-download-260nw-1378175036.jpg')
                              : FileImage(
                            CVImage,
                          ) as ImageProvider,
                            fit: BoxFit.contain,
                            width: double.infinity,),
                          IconButton(
                              onPressed: () {
                                RegesterCubit.get(context).getCVImage();
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
                  ),

                  SizedBox(
                    height: 40,
                  ),
                  BuildCondition(
                    condition: state is! RegesterCUpdateLodingeState,
                    fallback: (context) =>
                        Center(child: CircularProgressIndicator(),),
                    builder: (context) =>
                        defultButton(
                            text: 'التالي',
                            function: () {
                              if (formkey.currentState!.validate()) {
                                print(cubit.selectedValue);
                                // cubit.UpdateCRegister(
                                //     Qualification: qualificationcontroller.text,
                                //     counseling: cubit.selectedValue,
                                //     duration: durationcontroller.text,
                                //     CVPhoto: CVImage
                                // );
                              }
                            },
                            Background: Colors.red,
                            radius: 13),
                  ),
                    SizedBox(
                      height: 30,
                    ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
