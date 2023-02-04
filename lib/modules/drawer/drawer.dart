import 'package:consultation/layout/cubit/cubit.dart';
import 'package:flutter/material.dart';

import '../../policey.dart';
import '../../shared/components/components.dart';
import '../settings/settings.dart';
import '../support/support.dart';

class drawer_Widget extends StatefulWidget {

  @override
  State<drawer_Widget> createState() => _drawer_WidgetState();
}

class _drawer_WidgetState extends State<drawer_Widget> {
  @override
  Widget build(BuildContext context) {
    var cubit =AppCubit.get(context);
    return Drawer(
      backgroundColor: Color.fromRGBO(100, 185, 230, 1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 70,
          ),
          if (cubit.usermodel?.profilePicture != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image(
                image:
                NetworkImage('${cubit.usermodel?.profilePicture}'),
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
                navigateTo(context, policey());
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.info,
                      size: 35,
                    ),
                    Text(
                      'سياسة الخصوصية',
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
    );
  }
}
