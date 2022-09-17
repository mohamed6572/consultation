import 'package:consultation/layout/cubit/cubit.dart';
import 'package:consultation/layout/cubit/states.dart';
import 'package:consultation/modules/home/category_item.dart';
import 'package:consultation/modules/login/login_screan.dart';
import 'package:consultation/modules/notifiaction/notification.dart';
import 'package:consultation/modules/settings/settings.dart';
import 'package:consultation/modules/support/support.dart';
import 'package:consultation/shared/components/components.dart';
import 'package:consultation/shared/network/local/cash_helper.dart';
import 'package:consultation/shared/styles/colors.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/catI_tem_model.dart';
import '../shared/components/constens.dart';

class Home_Layout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..GetConsaltant()
        ..GetAllConsaltant()
        ..GetAllConversation()
      ,
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.grey.shade400,
            drawer: Drawer(
              backgroundColor: Color.fromRGBO(100, 185, 230, 1.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  if(cubit.usermodel?.others?.profilePicture!=null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image(
                      image: NetworkImage(
                          '${cubit.usermodel?.others?.profilePicture}'),
                      height: 100,
                      width: 100,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  InkWell(
                      onTap: () {
                        navigateTo(context, settings());
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.settings,
                              size: 35,
                            ),
                            Text(
                              'الاعدادات',
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      )),
                  InkWell(
                      onTap: () {
                        navigateTo(context, support());
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.headset_mic_rounded,
                              size: 35,
                            ),
                            Text(
                              'اتصل بنا',
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      )),
                  InkWell(
                      onTap: () {
                      cubit.SignOut(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.logout,
                              size: 35,
                              color: Colors.red.shade400,
                            ),
                            Text(
                              'تسجيل الخروج',
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
            appBar: AppBar(
              iconTheme: IconThemeData(size: 30),
              toolbarHeight: 100,
              title: cubit.titles[cubit.currentIndex],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.notifications_none,
                      color:Colors.lightBlue,
                      size: 33,
                    ),
                    onPressed: () {
                      navigateTo(context, Notification_Screen());
                    },
                  ),
                ),
//                 Padding(
//                   padding: const EdgeInsets.only(right: 20.0),
//                   child: IconButton(
//                     icon: Icon(
//                       Icons.send,
//                       color: Colors.lightBlue,
//                       size: 33,
//                     ),
//                     onPressed: () {
// cubit.sendNotification(
//   Image: 'https://scontent.fcai20-6.fna.fbcdn.net/v/t39.30808-6/261515859_401966121672872_696314712494114637_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=AQkUGu7b2CcAX85PB_5&_nc_ht=scontent.fcai20-6.fna&oh=00_AT-KJmGVM_8sa8Oi9d5hYsTgK3SpsuWp3w1En-yMvWKb8g&oe=63126B62',
//   body: 'hellokl',
//   title:'mohamedjlffffffff',
//   fcmtoken: 'cbeUNL_sQ1GPuJ7v_AU24S:APA91bFC5LPaR0gX7kl9ogay5Ly0Y8WbaXeg4O6fPVcNetCt8YQje2gke99WKcaJ-2okakWvgiZh4JRV9-6YOKfB5aPbtCSDlPHJuQwsC94pMJQBMVeV_T_WSz4ibzEMmKu7JyITTrHe'
// );
//                     },
//                   ),
//                 ),
              ],
            ),
            body: cubit.screans[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (v) {
                cubit.ChangeBotomIndex(v);
              },
              items: cubit.botItems,
            ),
          );
        },
      ),
    );
  }
}
