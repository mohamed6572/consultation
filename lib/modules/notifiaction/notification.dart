import 'package:consultation/layout/cubit/cubit.dart';
import 'package:consultation/layout/cubit/states.dart';
import 'package:consultation/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          body: ListView.separated(itemBuilder:(context, index) => Notification_Item(),

          itemCount: 9,
            separatorBuilder: (context, index) => SizedBox(height: 15,),
          ),
        );
      },
    );
  }
  Widget Notification_Item()=>Container(
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
    width: double.infinity,
    height: 190,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image(image: AssetImage('assets/images/ima.png'),height: 50,)),
            SizedBox(width: 9,),
            Expanded(
              child: Text('Ahmed asks to start a business plan with you, do you agree or not?',style: TextStyle(fontSize: 18),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,

              ),
            )

          ],
        ),
        Text('1 day and 10 minutes ago',style: TextStyle(fontSize: 12),
          textAlign: TextAlign.end,
        ),
        SizedBox(height: 15,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            defultButton(text: 'Refuse', function: (){},Background: Colors.red,width: 90),
            defultButton(text: 'Accept', function: (){},Background: Colors.green,width: 90),
          ],
        )
      ],
    ),
  );
}
