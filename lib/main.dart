import 'dart:io';

import 'package:consultation/layout/cubit/cubit.dart';
import 'package:consultation/layout/homeU_layout.dart';
import 'package:consultation/layout/home_layout.dart';
import 'package:consultation/models/notification_model.dart';
import 'package:consultation/modules/chat/payment/visa_screen.dart';
import 'package:consultation/modules/login/login_screan.dart';
import 'package:consultation/modules/onboard/onboarding.dart';
import 'package:consultation/shared/Bloc_Observer.dart';
import 'package:consultation/shared/components/constens.dart';
import 'package:consultation/shared/network/local/cash_helper.dart';
import 'package:consultation/shared/network/remote/dio_helper.dart';
import 'package:consultation/shared/styles/themes/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'layout/home_layout.dart';
import 'modules/login/cubit/cubit.dart';
import 'modules/login/login_screan.dart';
import 'modules/onboard/onboarding.dart';
Future<void> backgaondMessage(RemoteMessage message)async
{
  print('backgraond=> ${message.data.toString()}');

  notication.add(notefications!);

  // ShowToast(text: 'on message', state: ToastState.SUCSSES);
}
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
void main() {
  BlocOverrides.runZoned(
        () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      HttpOverrides.global = MyHttpOverrides();


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





      runApp(MyApp(onBorad: onBoard??false,));
    },
    blocObserver: MyBlocObserver(),
  );

}

class MyApp extends StatelessWidget {
  bool? onBorad ;
  MyApp({required this.onBorad});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(

      providers: [
        BlocProvider(
            create:(context) =>  AppCubit()
        ) ,
      BlocProvider(
            create:(context) =>  LoginCubit()
        )
      ],
      child: MaterialApp(
        title: 'consaltation',
        theme: lightTheme,
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,

        home: onBorad! ?  FirebaseAuth.instance.currentUser !=null? Home_Layout():Login_Screan(): onBoarding(),
      ),
    );

  }
}
