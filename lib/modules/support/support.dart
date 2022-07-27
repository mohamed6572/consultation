import 'package:consultation/layout/cubit/cubit.dart';
import 'package:consultation/layout/cubit/states.dart';
import 'package:consultation/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class support extends StatelessWidget{
  var emailcontroller = TextEditingController();
  var openioncontroller = TextEditingController();
  var complaintcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('الدعم'),
          ),
          body:SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                children: [
                  Container(

                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(top: 20,bottom: 20),

                    alignment: Alignment.topLeft,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 6), // changes position of shadow
                        ),
                      ],
                    ),
                    width: double.infinity,
                    height: 130,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,

                      children: [
                        Text('الايميل'),
                        SizedBox(height: 10,),
                        defultFormField(type: TextInputType.text , controller: emailcontroller,
                            maxlines: 1,
                            label: 'الايميل', validator: (v){}),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 6), // changes position of shadow
                        ),
                      ],
                    ),
                    margin: EdgeInsets.only(top: 20,bottom: 20),
                    width: double.infinity,
                    height: 130,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('رأيك'),
                        SizedBox(height: 10,),

                        defultFormField(type: TextInputType.text ,maxlines: 3, controller: openioncontroller, label: 'رأيك', validator: (v){}),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),

                    alignment: Alignment.topLeft,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 6), // changes position of shadow
                        ),
                      ],
                    ),
                    margin: EdgeInsets.only(top: 20,bottom: 20),
                    width: double.infinity,
                    height: 130,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,

                      children: [
                        Text('الشكوى'),
                        SizedBox(height: 10,),

                        defultFormField(type: TextInputType.text

                            ,maxlines: 8, controller: complaintcontroller, label: 'الشكوى', validator: (v){}),
                      ],
                    ),
                  ),

SizedBox(height: 20,),
                  defultButton(text: 'ارسال',
                      width: 160,
                      function: (){
                    cubit.sendEmailComplaint(email: emailcontroller.text , opnion: openioncontroller.text, complaint: complaintcontroller.text);
                  })
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
