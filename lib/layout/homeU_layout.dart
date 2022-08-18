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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/catI_tem_model.dart';
import '../modules/change_password/change_password_U.dart';

class HomeU_Layout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..GetAllConsaltant()
        ..GetAllConversation(),
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
                  InkWell(
                      onTap: () {
                        navigateTo(context, change_password_U());
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
                              'تغيير الباسورد',
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
                        cash_helper.removeData(key: 'ID').then((value) {});
                        cash_helper.removeData(key: 'tokenU').then((value) {
                          navigateToAndFinish(context, Login_Screan());
                        });
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
                      color: Colors.lightBlue,
                      size: 33,
                    ),
                    onPressed: () {
                      navigateTo(context, Notification_Screen());
                    },
                  ),
                )
              ],
            ),
            body: cubit.screans[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (v) {
                cubit.ChangeBotomIndex(v);
              },
              items: cubit.botItemsU,
            ),
          );
        },
      ),
    );
  }
}
