import 'package:buildcondition/buildcondition.dart';
import 'package:consultation/layout/cubit/cubit.dart';
import 'package:consultation/modules/login/login_screan1.dart';
import 'package:consultation/modules/register/cubit/cubit.dart';
import 'package:consultation/modules/register/cubit/states.dart';
import 'package:consultation/shared/components/components.dart';
import 'package:consultation/shared/components/constens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Consultant_Register_Screan1 extends StatelessWidget {
  var phonecontroller = TextEditingController();
  var countrycontroller = TextEditingController();
  var costcontroller = TextEditingController();
  var discripcontroller = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegesterCubit(),
      child: BlocConsumer<RegesterCubit, RegesterStates>(
        listener: (context, state) {
          if (state is RegesterCUpdateSucssesState)
            navigateTo(context, Login_Screan1());
        },
        builder: (context, state) {
          var profileImage = RegesterCubit.get(context).profileimage;
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
                                backgroundImage: profileImage == null
                                    ? NetworkImage(
                                        'https://media.tarkett-image.com/large/TH_24567080_24594080_24596080_24601080_24563080_24565080_24588080_001.jpg')
                                    : FileImage(
                                        profileImage,
                                      ) as ImageProvider,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  RegesterCubit.get(context).getProfileImage();
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
                          type: TextInputType.text,
                          controller: phonecontroller,
                          label: '0000000000+',
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'من فضلك ادخل رقم الهاتف';
                            }
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      itemregister('البلد'),
                      defultFormField(
                          type: TextInputType.text,
                          controller: countrycontroller,
                          label: 'البلد',
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'من فضلك ادخل البلد';
                            }
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      itemregister('سعر الخدمة'),
                      defultFormField(
                          type: TextInputType.number,
                          controller: costcontroller,
                          label: 'السعر',
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'من فضلك ادخل سعر الخدمة';
                            }
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      itemregister('نبذة عن أعمالك'),
                      defultFormField(
                          maxlines: 4,
                          type: TextInputType.text,
                          controller: discripcontroller,
                          label: 'نبذة عن أعمالك',
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'من فضلك ادخل نبذة عن أعمالك';
                            }
                          }),
                      SizedBox(
                        height: 40,
                      ),
                      BuildCondition(
                        condition: state is! RegesterCUpdateLodingeState,
                        fallback: (context) => Center(
                          child: CircularProgressIndicator(),
                        ),
                        builder: (context) => defultButton(
                            text: 'تسجيل',
                            function: () {
                              if (formkey.currentState!.validate()) {
                                // cubit.UpdateCRegister1(
                                //     phone: phonecontroller.text,
                                //     price: costcontroller.text,
                                //     country: countrycontroller.text,
                                //     About: discripcontroller.text,
                                //     profilePicture: profileImage);
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
