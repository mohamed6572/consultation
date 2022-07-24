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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegesterCubit(),
      child: BlocConsumer<RegesterCubit, RegesterStates>(
        listener: (context, state) {},
        builder: (context, state) {
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
                      height: 40,
                    ),
                    itemregister('المؤهل'),
                    defultFormField(
                      maxlines: 2,
                        type: TextInputType.text,
                        controller: qualificationcontroller,
                        label: 'حاصل علي ....',
                        validator: (v) {}),
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
                                  hint: Text('اختار نوع الاستشارة التي ستقدمها '),
                                  value: cubit.selectedValue,
                                  onChanged: (value) {
                                    cubit.changeSelected(value);
                                  },
                                  items: cubit.items.map((e) {
                                    return DropdownMenuItem(
                                        value: e['name'].toString(),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Image.asset(
                                              e['image'],
                                              width: 25,
                                            ),
                                            // Image(image: AssetImage(e['image']),width: 25,),
                                            Container(
                                              margin: EdgeInsets.only(left: 15),
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
                        validator: (v) {}),
                    SizedBox(
                      height: 25,
                    ),
                    itemregister('إرفاق الشهادة صورة'),
                    Container(
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: Colors.grey.shade200,
                          border: Border.all(color: Colors.black54)),
                      child: Center(
                        child: Icon(
                          Icons.image,
                          size: 60,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    defultButton(
                        text: 'التالي',
                        function: () {
                          print(cubit.selectedValue);
                          navigateTo(context, Consultant_Register_Screan1());
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
