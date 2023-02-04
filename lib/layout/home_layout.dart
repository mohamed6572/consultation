import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'package:uuid/uuid.dart';

import '../models/catI_tem_model.dart';
import '../modules/drawer/drawer.dart';
import '../policey.dart';
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
        listener: (context, state) {
          if (state is signoutSucssesState) {
            ShowToast(text: 'نلقاق قريبا', state: ToastState.ERROR);
            navigateToAndFinish(context, Login_Screan());
          }
        },
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          final _pageController = PageController(initialPage: cubit.currentIndex);


          return Scaffold(
            backgroundColor: Colors.grey.shade200,
            drawer: drawer_Widget(),
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
                      color: Color.fromARGB(255, 14, 73, 105),
                      size: 33,
                    ),
                    onPressed: () {
                      cubit.ChaIndex();
                     // navigateTo(context, Notification_Screen());
                    },
                  ),
                ),

              ],
            ),
            body: cubit.screans[cubit.currentIndex],

            bottomNavigationBar: AnimatedNotchBottomBar(
                pageController: _pageController,

                onTap: (v) {
                  cubit.ChangeBotomIndex(v);

                  //_pageController.animateToPage(v, duration: Duration(microseconds: 500), curve: Curves.bounceIn);
                },
                showShadow: true,
                showBlurBottomBar: true,
                notchColor: Colors.blueGrey.shade400,

                showLabel: false,
                bottomBarItems:cubit.botItems),
            // bottomNavigationBar: AwesomeBottomNav(
            //   // icons: [
            //   //   Icons.home_outlined,
            //   //   Icons.shopping_cart_outlined,
            //   //   Icons.category_outlined,
            //   //   Icons.account_circle_outlined,
            //   // ],
            //   // highlightedIcons: [
            //   //   Icons.home,
            //   //   Icons.message,
            //   //   Icons.person,
            //   //   Icons.attach_money,
            //   // ],
            //   onTapped: (v) {
            //     cubit.ChangeBotomIndex(v);
            //   },
            //   bodyBgColor: Color.fromARGB(255, 14, 73, 105),
            //   highlightColor: Color(0xFFFF9944),
            //   navFgColor: Colors.grey.withOpacity(0.5),
            //   navBgColor: Colors.white,
            // ),
          );
        },
      ),
    );
  }
}
