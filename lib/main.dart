import 'package:consultation/layout/cubit/cubit.dart';
import 'package:consultation/layout/home_layout.dart';
import 'package:consultation/modules/login/login_screan.dart';
import 'package:consultation/modules/onboard/onboarding.dart';
import 'package:consultation/shared/Bloc_Observer.dart';
import 'package:consultation/shared/network/local/cash_helper.dart';
import 'package:consultation/shared/network/remote/dio_helper.dart';
import 'package:consultation/shared/styles/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'layout/home_layout.dart';
import 'modules/login/login_screan.dart';
import 'modules/onboard/onboarding.dart';

void main() {
  BlocOverrides.runZoned(
        () async {
      WidgetsFlutterBinding.ensureInitialized();
      Dio_Helper.init();
      await cash_helper.init();
      bool? onBoard = cash_helper.getData(key: 'onboard');
      // token = cash_helper.getData(key: 'token');
      // print(token);
      Widget widget ;
      if(onBoard !=null){
        // if(token !=null) widget = Home_Layout();
        // else
          widget =  Login_Screan();
      }else{
        widget = onBoarding();
      }



      runApp(MyApp(start: widget,));
    },
    blocObserver: MyBlocObserver(),
  );

}

class MyApp extends StatelessWidget {
  Widget start ;
  MyApp({required this.start});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: MaterialApp(
        title: 'consaltation',
        theme: lightTheme,
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        home: start ,
      ),
    );
  }
}
