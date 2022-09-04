import 'package:consultation/layout/cubit/cubit.dart';
import 'package:consultation/layout/home_layout.dart';
import 'package:consultation/shared/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../layout/cubit/states.dart';

class Paypal extends StatelessWidget {
  Paypal({required this.price,required this.balance,required this.ID});

  final price;
  final balance;
  final ID;

  String _loadHTML() {
    return '''
      <html>
        <body onload="document.f.submit();">
          <form id="f" name="f" method="post" action="https://consultant1.herokuapp.com/api/pay/pay">
            <input type="hidden" name="price" value="${price}" />
          </form>
        </body>
      </html>
    ''';
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {

      },
      builder: (context, state) {

      return
       Scaffold(
        appBar: AppBar(),
        body: WebView(
          onPageFinished: (page) {
            if (page.contains('/success')) {
              ShowToast(text: 'تمت عمليه الدفع بنجاج', state: ToastState.SUCSSES);
              print('${balance+price}');
              print('${(1000*70)/100}');
              int  p = ((price*70)/100).toInt();

              print('$p++++');
              print('${70%100}');
              AppCubit.get(context).Update_Balance(
                id: ID,
                balance: '${balance+p}'
              );
             navigateTo(context, Home_Layout());
            }
          },
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl:
              Uri.dataFromString(_loadHTML(), mimeType: 'text/html').toString(),
        ),
      );}
    );
  }
}
