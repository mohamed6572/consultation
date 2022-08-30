import 'package:buildcondition/buildcondition.dart';
import 'package:consultation/layout/cubit/cubit.dart';
import 'package:consultation/layout/cubit/states.dart';
import 'package:consultation/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Balance_Screan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = AppCubit.get(context).usermodel?.others?.price;
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
                children: [
                  paymentwidget(pay: '0.00', text: 'الرصيد الكلي'),
                  paymentwidget(pay: '0.00', text: 'رصيد معلق'),
                  paymentwidget(pay: '0.00', text: 'أرباح يمكن سحبها'),
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
