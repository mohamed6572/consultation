import 'package:consultation/layout/cubit/cubit.dart';
import 'package:consultation/models/catI_tem_model.dart';
import 'package:consultation/modules/home/cat_more_details.dart';
import 'package:consultation/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../models/all_cosultant_model.dart';

class Cat_Details extends StatelessWidget{
  catItem_model model;
  Cat_Details({required this.model});
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey.shade400,
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
      body: ListView.builder(itemBuilder:(context, index) =>  catItem_Detales(model.list[index],model,context),itemCount: model.list.length,)
    );
  }
  Widget catItem_Detales(Consultants model,model1,context)=>Container(
      height: 170,
      margin: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.star,color: Colors.orangeAccent,),
                      Text('${model.rating}')
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Icon(Icons.attach_money,color: Colors.green,),
                      Text('${model.price}',style: TextStyle(fontSize: 18,color: Colors.green ),)
                    ],
                  ),

                ],
              ),
              SizedBox(width: 13,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('${model.username}',maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            height: 1, fontWeight: FontWeight.w500, fontSize: 20)),
                    SizedBox(height: 10,),
                    Text('${model.counseling}',maxLines: 1,
                        overflow: TextOverflow.ellipsis, style: TextStyle(
                            height: 1.1, fontSize: 12, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              SizedBox(width: 13,),
              Image(
                  image: AssetImage('${model.profilePicture}'),
                height: 70,
                width: 70,
              ),
            ],
          ),
          SizedBox(height: 20,),
          defultButton(text: 'اضغط للحصول علي تفاصيل', function: (){
            navigateTo(context, Cat_More_Details( model: model1,model1: model,));
          },Background: HexColor('#64B9E6'),width: 250)
        ],
      )
  );
}
