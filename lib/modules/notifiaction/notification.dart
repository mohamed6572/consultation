import 'package:consultation/layout/cubit/cubit.dart';
import 'package:consultation/layout/cubit/states.dart';
import 'package:consultation/models/notification_model.dart';
import 'package:consultation/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/constens.dart';

class Notification_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 100,
            elevation: 4,
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('الاشعارات'),
                Icon(Icons.notifications_none)
              ],
            ),
          ),
          body: ListView.separated(itemBuilder:(context, index) => Notification_Item(notication[index],context),

          itemCount: notication.length,
            separatorBuilder: (context, index) => SizedBox(height: 15,),
          ),
        );
      },
    );
  }
  Widget Notification_Item(Notification_Model model,context)=>Container(
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 2,
          offset: Offset(0, 6), // changes position of shadow
        ),
      ],
    ),
    margin: EdgeInsets.only(top: 15, right: 15, left: 15, bottom: 15),
    width: MediaQuery.of(context).size.width*0.6,
    height: 120,
    child:   Row(

      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Image(image: NetworkImage('${model.image}'),height: 50,)),
        SizedBox(width: 14,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${model.name}',style: TextStyle(fontSize: 18),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width*0.6,
                child: Text('${model.text}',style: TextStyle(fontSize: 18,height: 2),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,

                ),
              ),
            )
          ],
        )


      ],
    ),
  );
}
