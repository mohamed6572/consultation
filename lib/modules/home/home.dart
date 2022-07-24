import 'package:consultation/models/catI_tem_model.dart';
import 'package:consultation/modules/home/category_item.dart';
import 'package:consultation/shared/styles/colors.dart';
import 'package:flutter/material.dart';

class Home_Screan extends StatelessWidget{
  List<catItem_model> cat_item = [
    catItem_model(
        image: 'assets/images/consultation_image/cat_image1.png',
        color: cat1,
        text: 'استشارة قانونية'),
    catItem_model(
        image: 'assets/images/consultation_image/cat_image2.png',
        color: cat2,

        text: 'استشارة معمارية'),
    catItem_model(
        color: cat3,
        image: 'assets/images/consultation_image/cat_image3.png',
        text: 'استشارة رجل اعمال'),
    catItem_model(
        color: cat4,
        image: 'assets/images/consultation_image/cat_image4.png',
        text: 'استشارة نفسية'),
    catItem_model(
        color: cat5,
        image: 'assets/images/consultation_image/cat_image5.png',
        text: 'استشارة اسرية'),
    catItem_model(
        color: cat7,
        image: 'assets/images/consultation_image/cat_image7.png',
        text: 'استشارة شعر وجمال'),
    catItem_model(
        color: cat8,
        image: 'assets/images/consultation_image/cat_image8.png',
        text: 'استشارة تغذية'),
    catItem_model(
        color: cat9,
        image: 'assets/images/consultation_image/cat_image9.png',
        text: 'استشارة برمجية'),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(25),
            topStart: Radius.circular(25),

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
                  (index) => Cat_Item(model: cat_item[index], index: index)),
        ),
      ),
    );
  }
}
