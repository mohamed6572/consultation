import 'package:consultation/layout/cubit/cubit.dart';
import 'package:consultation/layout/cubit/states.dart';
import 'package:consultation/models/all_cosultant_model.dart';
import 'package:consultation/models/catI_tem_model.dart';
import 'package:consultation/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../models/chat_item_model.dart';

class Rating_Screan extends StatelessWidget {
  Consultants model;

  Rating_Screan({required this.model});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                toolbarHeight: 65,
                centerTitle: true,
                backgroundColor: Colors.white,
                title: Text(
                  model.username ?? '',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 28),
                ),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'تم انتهاء المحادثة',
                    style: TextStyle(fontSize: 24),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(20),
                    height: 170,
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 6), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text('كيف كانت الخدمة ؟', style: TextStyle(fontSize: 22),),
                        SizedBox(height: 25,),
                        RatingBar.builder(
                          initialRating:cubit.rating ,
                            itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                            onRatingUpdate: (rating) {
                            cubit.RatingApp(rating);
                            }),
                      ],
                    ),
                  )
                ],
              ));
        },
        listener: (context, state) {
          print(AppCubit.get(context).rating);
          if(state is AppRatingState)
          AppCubit.get(context).rateConsaltant(
            id: model.sId,
              rate: AppCubit.get(context).rating.toInt()
          );
          AppCubit.get(context).Update_Conseling(
              id: model.sId!,
              counseling:  model.counseling! + 1
          );
          if(state is RatingSuccsessState)
          Navigator.pop(context);

        });
  }
}
