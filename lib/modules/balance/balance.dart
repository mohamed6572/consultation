import 'package:buildcondition/buildcondition.dart';
import 'package:consultation/layout/cubit/cubit.dart';
import 'package:consultation/layout/cubit/states.dart';
import 'package:consultation/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/home_layout.dart';

class Balance_Screan extends StatelessWidget {
  var paypal_controller = TextEditingController();
  var price_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var model = AppCubit.get(context).usermodel?.others;
        var cubit = AppCubit.get(context);
        return BuildCondition(
          fallback: (context) => Center(
            child: Text("غير مصرح لك"),
          ),
          condition: model!= null,
          builder: (context) => Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.only(top: 20),
            color: Colors.white,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  paymentwidget(pay: '${model?.balance}', text: 'الرصيد الكلي'),
                  Divider(
                    thickness: 2.0,
                  ),
                  Text('يمكنك السحب بعد 14 يوم من استلامك لاموالك ',style: TextStyle(height: 1.7),textAlign: TextAlign.center),
                  Text('ايميل البايبال الخاص بك',style: TextStyle(height: 2.0),textAlign: TextAlign.end,),
                  defultFormField(type: TextInputType.emailAddress, controller: paypal_controller, label: 'paypal', validator: (v){}),
                  Text('المبلغ',style: TextStyle(height: 2.0),textAlign: TextAlign.end,),
                  defultFormField(type: TextInputType.phone, controller: price_controller, label: 'المبلغ', validator: (v){}),
                 SizedBox(height: 20,),
                  defultButton(text: 'سحب', function: (){
                    cubit.sendEmailPayment(
                      paypal: paypal_controller.text,
                      price: price_controller.text,
                      email: model?.email??''
                    );
                    String b =  ( int.parse(model!.balance!)  - int.parse(price_controller.text) ).toString();
                    print(b);
                    cubit.Update_Balance(
                      balance:b,
                      id: model.sId
                    );
                    navigateTo(context, Home_Layout());
                  },width: 100)
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget paymentwidget({pay, text}) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.attach_money,
                color: Colors.green,
              ),
              Text(
                pay,
                style: TextStyle(fontSize: 18, color: Colors.green),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            text,
            style: TextStyle(fontSize: 18),
          ),
        ],
      );
}
