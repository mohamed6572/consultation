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
    return BlocConsumer<AppCubit,AppStates>(builder:(context, state) {
      var editImage = AppCubit.get(context).editprofileimage;

      var cubit =AppCubit.get(context);
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
                                  ? NetworkImage('https://media.tarkett-image.com/large/TH_24567080_24594080_24596080_24601080_24563080_24565080_24588080_001.jpg')
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
    },  listener: (context, state) {

    },);
  }
}
