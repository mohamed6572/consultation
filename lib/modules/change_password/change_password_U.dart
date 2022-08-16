import 'package:consultation/layout/cubit/cubit.dart';
import 'package:consultation/layout/cubit/states.dart';
import 'package:consultation/shared/components/components.dart';
import 'package:consultation/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class change_password_U extends StatelessWidget{
var changePasswordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('تغيير الباسورد'),
          ),
          body:Column(
            children: [
              SizedBox(height: 30,),
              Padding(
                padding: EdgeInsets.all(20),
                child:
                defultFormField(
                    suffix: Icons.edit,
                    maxlines: 4,
                    type: TextInputType.text,
                    controller: changePasswordcontroller,
                    label: 'الباسورد الجديد',
                    validator: (v) {}),
              ),
              defultButton(
                  text: 'تغيير',
                  function: () {
                    cubit.ChangePasswrodUser(
                      password: changePasswordcontroller.text
                    );
                  },
                  width: 120,
                  Background: defColor,
                  radius: 13),
            ],
          )
        );
      },
    );
  }
}
