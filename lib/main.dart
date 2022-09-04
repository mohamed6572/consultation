import 'package:consultation/layout/cubit/cubit.dart';
import 'package:consultation/layout/homeU_layout.dart';
import 'package:consultation/layout/home_layout.dart';
import 'package:consultation/models/notification_model.dart';
import 'package:consultation/modules/login/login_screan.dart';
import 'package:consultation/modules/onboard/onboarding.dart';
import 'package:consultation/shared/Bloc_Observer.dart';
import 'package:consultation/shared/components/constens.dart';
import 'package:consultation/shared/network/local/cash_helper.dart';
import 'package:consultation/shared/network/remote/dio_helper.dart';
import 'package:consultation/shared/styles/themes/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'layout/home_layout.dart';
import 'modules/login/login_screan.dart';
import 'modules/onboard/onboarding.dart';
Future<void> backgaondMessage(RemoteMessage message)async
{
  print('backgraond=> ${message.data.toString()}');

  notication.add(notefications!);

  // ShowToast(text: 'on message', state: ToastState.SUCSSES);
}

void main() {
  BlocOverrides.runZoned(
        () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();

      Dio_Helper.init();
      await cash_helper.init();
      bool? onBoard = cash_helper.getData(key: 'onboard');
      token = cash_helper.getData(key: 'token');
      ID = cash_helper.getData(key: 'ID');
      //message

      var messageToken =await FirebaseMessaging.instance.getToken();
      print('==${messageToken}');
      FirebaseMessaging.onMessage.listen((event) {
        print('on message=> ${event.data.toString()}');
        notefications = Notification_Model.fromJson(event.data);

        notication.add(notefications!);

       // ShowToast(text: 'on message', state: ToastState.SUCSSES);

      });
      FirebaseMessaging.onMessageOpenedApp.listen((event) {
        print(' on opend=> ${event.data.toString()}');
        //ShowToast(text: 'on message opend', state: ToastState.SUCSSES);
        notication.add(notefications!);


      });

      FirebaseMessaging.onBackgroundMessage(backgaondMessage);
      ////
      print(token);
      Widget widget ;
      if(onBoard !=null){
        if(token !=null) {
          widget = Home_Layout();
        }
       else
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
    return MultiBlocProvider(

      providers: [
        BlocProvider(
            create:(context) =>  AppCubit()..GetAllConsaltant())
      ],
      child: MaterialApp(
        title: 'consaltation',
        theme: lightTheme,
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        home: start,
      ),
    );
  }
}
