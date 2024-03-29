import 'package:consultation/layout/cubit/cubit.dart';
import 'package:consultation/layout/cubit/states.dart';
import 'package:consultation/shared/components/components.dart';
import 'package:consultation/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class change_password extends StatelessWidget{
var changePasswordcontroller = TextEditingController();
var formkey = GlobalKey<FormState>();
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
          body:Form(
            key: formkey,
            child: Column(
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
                      validator: (v) {
                        RegExp regex = RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                        if (v!.isEmpty) {
                          return 'من فضلك ادخل الباسورد';
                        } else {
                          if (!regex.hasMatch(v)) {
                            return 'Password must be at least 8 characters,\n include an uppercase letter ,\n number and symbol like [@,#.*]';
                          } else {
                            return null;
                          }
                        }
                      }),
                ),
                defultButton(
                    text: 'تغيير',
                    function: () {
                    //  if (formkey.currentState!.validate()) {
                        cubit.ChangePasswrodConsaltant(
                            password: changePasswordcontroller.text
                        );
                     // }

                    },
                    width: 120,
                    Background: defColor,
                    radius: 13),
              ],
            ),
          )
        );
      },
    );
  }
}
