import 'package:consultation/models/catI_tem_model.dart';
import 'package:consultation/modules/home/cat_details.dart';
import 'package:consultation/shared/components/components.dart';
import 'package:consultation/shared/styles/colors.dart';
import 'package:flutter/material.dart';

class Cat_Item extends StatelessWidget {
  int index;
  catItem_model model;
  Cat_Item({required this.model, required this.index});
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: (){
        navigateTo(context, Cat_Details(model: model,));
      },
      child:   Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 6), // changes position of shadow
              ),
            ],
            color: catColor[index],
            borderRadius: BorderRadius.circular(0)
        ),
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(image: AssetImage(model.image)),
            SizedBox(height: 10,),
            Text(model.text,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15),)
          ],
        ),

      ),
    );
  }
}

