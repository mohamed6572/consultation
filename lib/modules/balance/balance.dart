import 'package:flutter/material.dart';

class Balance_Screan extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(top: 20),
      color: Colors.white,
      child:Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 15),
        child: Column(
          children: [
            paymentwidget(pay: '0.00',text: 'الرصيد الكلي'),
            paymentwidget(pay: '0.00',text: 'رصيد معلق'),
            paymentwidget(pay: '0.00',text: 'أرباح بمكن سحبها'),

          ],
        ),
      ),
    );

  }
  Widget paymentwidget({pay,text})=> Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          Icon(Icons.attach_money,color: Colors.green,),
          Text(pay,style: TextStyle(fontSize: 18,color: Colors.green ),)
        ],
      ),
      SizedBox(height: 10,),
      Text(text,style: TextStyle(fontSize: 18),),
    ],
  );
}
