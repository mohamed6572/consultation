import 'package:consultation/models/catI_tem_model.dart';
import 'package:consultation/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../models/all_cosultant_model.dart';

class Cat_More_Details extends StatelessWidget{

  catItem_model model;
  Consultants? model1;
  Cat_More_Details({required this.model,required this.model1});
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        centerTitle: true,
        backgroundColor: model.color,
        title: Row(
          children: [
            SizedBox(width: 30,),
            Text(model.text,
            style: TextStyle(fontWeight: FontWeight.w500,fontSize: 28),),
            SizedBox(width: 10,),
            Image(image: AssetImage(model.image),height: 35,)
          ],
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('${model1?.username}',style: TextStyle(fontSize: 28 ),),
              SizedBox(width: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 40),
                child: Row(
                  children: [
                    Text('${model1?.price}',style: TextStyle(fontSize: 18,color: Colors.blueAccent ),),
                    Icon(Icons.attach_money,color: Colors.blueAccent,)
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 30,),
          Container(

            width: double.infinity,
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Image(image: NetworkImage('${model1?.profilePicture}'),width: double.infinity,fit: BoxFit.fill, height: 420,),
               Container(
                 height: 320,
                 padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                 margin: EdgeInsets.symmetric(horizontal: 30),
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.only(
                     topLeft: Radius.circular(15),
                     topRight: Radius.circular(15),
                   )
                 ),
                 child: SingleChildScrollView(
                   physics: BouncingScrollPhysics(),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.stretch,
                     children: [
                       Text('نبذة',style: TextStyle(fontSize: 18),textAlign: TextAlign.end,),
                       SizedBox(height: 20,),
                       Text('${model1?.about}',style: TextStyle(fontSize: 18),textAlign: TextAlign.center,),
                       SizedBox(height: 20,),
                       Image(image: NetworkImage('${model1?.cVPhoto}'),height: 200,width: double.infinity,),
                     ],
                   ),
                 ),
               ),
//'https://consultant1.herokuapp.com${model1?.cVPhoto?.substring(6)}'

               ],
            ),
          ),
          SizedBox(height: 50,),
          defultButton(text: 'بدأ المحادثة', function: (){},width: 180,Background: Colors.green),




        ],
      )
    );
  }
}
