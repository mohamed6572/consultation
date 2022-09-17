import 'package:consultation/layout/cubit/cubit.dart';
import 'package:consultation/layout/cubit/states.dart';
import 'package:consultation/modules/chat/payment/paypal_screen.dart';
import 'package:consultation/modules/chat/payment/visa_screen.dart';
import 'package:consultation/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../models/all_cosultant_model.dart';

class Payment_Screan extends StatelessWidget{
  Consultants model;

  Payment_Screan({required this.model});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {

      },
      builder: (context, state) {

      return
     Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          centerTitle: true,
          elevation: 5,
          title: Text('الدفع'),
        ),
        body: Column(
          children: [
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
              margin: EdgeInsets.only(top: 20, right: 20, left: 20,bottom: 20),
              width: double.infinity,
              height: 100,
              child: Center(child: Row(
                children: [
                  Text('Total'),
                  Spacer(),
                  Row(
                    children: [
                      Text('${model.price}'),
                      Icon(Icons.attach_money,color: Colors.black,)
                    ],
                  ),

                ],
              )),
            ),
            SizedBox(height: 20,),
            Text('من فضلك اختر طريقة الدفع المناسبة',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
            SizedBox(height: 50,),
            // Center(child: MaterialButton(onPressed: (){
            //
            //   int price;
            //
            //   price = int.parse(model.price!);
            //
            //   print(price);
            //   navigateTo(context, Paypal(price: price,balance:double.parse(model.balance!),ID:model.sId ,));
            //
            // },child: Image(image: AssetImage('assets/images/paypal.png'),),),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(onPressed: (){


                  int price;

                  price = int.parse(model.price!);

                  print(price);
                  navigateTo(context, Visa_Screen(price: price,balance:double.parse(model.balance!),ID:model.sId ,));


                },child: Image(image: AssetImage('assets/images/visa.png'),),),
                SizedBox(width: 20,),
                MaterialButton(onPressed: (){

                   int price;

                   price = int.parse(model.price!);

                   print(price);
                navigateTo(context, Paypal(price: price,balance:double.parse(model.balance!),ID:model.sId ,));

                },child: Image(image: AssetImage('assets/images/paypal.png'),),),
              ],
            ),


          ],
        )
      );}
    );
  }
  
}
