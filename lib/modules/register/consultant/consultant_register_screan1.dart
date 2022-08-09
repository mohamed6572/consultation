import 'package:consultation/layout/cubit/cubit.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegesterCubit(),
      child: BlocConsumer<RegesterCubit, RegesterStates>(
        listener: (context, state) {},
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
                                  ? NetworkImage('https://media.tarkett-image.com/large/TH_24567080_24594080_24596080_24601080_24563080_24565080_24588080_001.jpg')
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
                        validator: (v) {}),
                    SizedBox(
                      height: 20,
                    ),
                    itemregister('البلد'),
                    defultFormField(
                        type: TextInputType.text,
                        controller: countrycontroller,
                        label: 'البلد',
                        validator: (v) {}),
                    SizedBox(
                      height: 20,
                    ),
                    itemregister('سعر الخدمة'),

                    defultFormField(
                        type: TextInputType.number,
                        controller: costcontroller,
                        label: 'السعر',
                        validator: (v) {}),
                     SizedBox(
                       height: 20,
                    ),
                    itemregister('نبذة عن أعمالك'),

                    defultFormField(
                      maxlines: 4,
                        type: TextInputType.text,
                        controller: discripcontroller,
                        label: 'نبذة عن أعمالك',
                        validator: (v) {}),

                    SizedBox(
                      height: 40,
                    ),
                    defultButton(
                        text: 'تسجيل',
                        function: () {
                          print(cubit.selectedValue);
                        },
                        Background: Colors.red,
                        radius: 13),
                    SizedBox(
                      height: 30,
                    ),
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
