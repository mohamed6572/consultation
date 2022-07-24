import 'package:consultation/modules/register/cubit/cubit.dart';
import 'package:consultation/modules/register/cubit/states.dart';
import 'package:consultation/shared/components/components.dart';
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
                'Continue',
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
                    defultFormField(
                        type: TextInputType.text,
                        controller: qualificationcontroller,
                        label: 'Qualification',
                        validator: (v) {}),
                    SizedBox(
                      height: 30,
                    ),
                    Text('What type of counseling will you provide?'),
                    SizedBox(
                      height: 9,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          border: Border.all(color: Colors.black54, width: 1),
                          borderRadius: BorderRadius.circular(13)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButton<dynamic>(
                                hint: Text('Choose the type of counseling '),
                                value: cubit.selectedValue,
                                onChanged: (value) {
                                  cubit.changeSelected(value);
                                },
                                items: cubit.items.map((e) {
                                  return DropdownMenuItem(
                                      value: e['name'].toString(),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            e['image'],
                                            width: 25,
                                          ),
                                          // Image(image: AssetImage(e['image']),width: 25,),
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(e['name']),
                                          )
                                        ],
                                      ));
                                }).toList(),
                              ),
                            ),
                          ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    defultFormField(
                        type: TextInputType.text,
                        controller: durationcontroller,
                        label: 'Duration of experience',
                        validator: (v) {}),
                    SizedBox(
                      height: 35,
                    ),
                    Text('Download CV as PDF'),
                    SizedBox(
                      height: 9,
                    ),
                    Container(
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: Colors.grey.shade200,
                          border: Border.all(color: Colors.black54)),
                      child: Center(
                        child: Icon(
                          Icons.picture_as_pdf_outlined,
                          size: 60,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    defultButton(
                        text: 'SignUp',
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
