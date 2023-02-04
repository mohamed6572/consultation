import 'package:consultation/layout/cubit/cubit.dart';
import 'package:consultation/layout/cubit/states.dart';
import 'package:consultation/models/catI_tem_model.dart';
import 'package:consultation/modules/home/category_item.dart';
import 'package:consultation/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import 'cat_details.dart';

class Home_Screan extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    var cubit = AppCubit.get(context);
    List<catItem_model> cat_item = [
      catItem_model(
          image: 'assets/images/consultation_image/cat_image1.png',
          color: cat1,
          list: cubit.law,
          text: 'استشارة قانونية'),
      catItem_model(
          image: 'assets/images/consultation_image/cat_image2.png',
          color: cat2,
          list: cubit.engeier,
          text: 'استشارة معمارية'),
      catItem_model(
          color: cat3,
          list: cubit.man,

          image: 'assets/images/consultation_image/cat_image3.png',
          text: 'استشارة رجل اعمال'),
      catItem_model(
          color: cat4,
          list: cubit.relashin,
          image: 'assets/images/consultation_image/cat_image4.png',
          text: 'استشارة نفسية'),
      catItem_model(
          color: cat5,
          list: cubit.family,

          image: 'assets/images/consultation_image/cat_image5.png',
          text: 'استشارة اسرية'),
      catItem_model(
          color: cat7,
          list: cubit.hear,

          image: 'assets/images/consultation_image/cat_image7.png',
          text: 'استشارة شعر وجمال'),
      catItem_model(
          color: cat8,
          list: cubit.health,

          image: 'assets/images/consultation_image/cat_image8.png',
          text: 'استشارة تغذية'),
      catItem_model(
          color: cat9,
          list: cubit.programing,

          image: 'assets/images/consultation_image/cat_image9.png',
          text: 'استشارة برمجية'),
    ];
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return      Container(
          margin: EdgeInsets.only(top: 10,bottom: 10),
          padding: EdgeInsets.only(top: 10,right: 7,left: 7),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 6), // changes position of shadow
                ), BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(6, 0), // changes position of shadow
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadiusDirectional.only(
                topEnd: Radius.circular(25),
                topStart: Radius.circular(25),
                bottomEnd: Radius.circular(25),
                bottomStart: Radius.circular(25),

              )
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 20,right: 5,left: 5),
            child: GridView.count(
              physics: BouncingScrollPhysics(),

              crossAxisCount: 3,
              mainAxisSpacing: 25.0,
              crossAxisSpacing: 15.0,
              childAspectRatio: 1 / 1.42,
              children: List.generate(cat_item.length,
                      (index) => Cat_Item(model: cat_item[index], index: index,context: context)),
            ),
          ),
        );
      },
    );
  }
  Cat_Item ({required int index,
  required catItem_model model,context})=> InkWell(
    onTap: () {
      navigateTo(
          context,
          Cat_Details(
            model: model,
          ));

      print(AppCubit.get(context).usermodel?.profilePicture);
    },
    child: Container(

      decoration: BoxDecoration(

          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 6), // changes position of shadow
            ),
          ], color: catColor[index],
          borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(image: AssetImage(model.image)),
          SizedBox(
            height: 10,
          ),
          Text(
            model.text,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15,
              // color: Colors.white
            ),
          )
        ],
      ),
    ),
  );
}
